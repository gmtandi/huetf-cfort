void () T_MissileTouch;
void () info_player_start;
void (entity targ, entity attacker) ClientObituary;

void (entity Goal, entity AP, float addb) DoResults;
float (entity Goal, entity AP) Activated;
float (entity targ, entity attacker, float damage) TeamEqualiseDamage;

void () monster_death_use = {
    if (self.flags & FL_FLY)
        self.flags = self.flags - FL_FLY;

    if (self.flags & FL_SWIM)
        self.flags = self.flags - FL_SWIM;

    if (!self.target)
        return;

    activator = self.enemy;
    SUB_UseTargets();
};

float (entity targ, entity inflictor) CanDamage = {
    if (targ.movetype == MOVETYPE_PUSH) {

        traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax),
                  TRUE, self);
        if (trace_fraction == 1)
            return (TRUE);
        if (trace_ent == targ)
            return (TRUE);
        return (FALSE);
    }

    traceline(inflictor.origin, targ.origin, TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '15 -15 0', 1, self);
    if (trace_fraction == 1)
        return (TRUE);
    return (FALSE);
};

void (entity targ, entity attacker) Killed = {
    local entity oself;

    if (attacker == world && (targ.classname == "building_dispenser" || targ.classname == "building_sentrygun"))
        attacker = targ;

    oself = self;
    self = targ;
    if (self.health < -99)
        self.health = -99;

    if ((self.movetype == MOVETYPE_PUSH) ||
        (self.movetype == MOVETYPE_NONE)) {

        self.th_die();
        self = oself;
        return;
    }

    self.enemy = attacker;

    if (self.flags & FL_MONSTER) {

        killed_monsters = killed_monsters + 1;
        WriteByte(MSG_ALL, SVC_KILLEDMONSTER);
    }

    ClientObituary(self, attacker);
    self.takedamage = DAMAGE_NO;
    self.touch = SUB_Null;

    monster_death_use();
    self.th_die();
    self = oself;
};

void (entity targ, entity inflictor, entity attacker,
      float damage) T_Damage = {
    local vector dir;
    local entity oldself, te;
    local float save;
    local float take;

    if (!targ.takedamage)
        return;

    if (attacker.classname == "player")
        damage = damage * 0.9;

    if (attacker.classname == "player") {

        if (attacker.super_damage_finished > time)
            damage = damage * 4;

        if ((targ.classname != "player") && (targ.classname != "bot")) {

            if (!Activated(targ, attacker)) {

                if (targ.else_goal != 0) {

                    te = Findgoal(targ.else_goal);
                    if (te)
                        AttemptToActivate(te, attacker, targ);
                }
                return;
            }
        }
    }
    damage_attacker = attacker;
    if (teamplay & (TEAMPLAY_LESSSCOREHELP | TEAMPLAY_LESSPLAYERSHELP))
        damage = TeamEqualiseDamage(targ, attacker, damage);

    save = ceil(targ.armortype * damage);
    if (save >= targ.armorvalue) {

        save = targ.armorvalue;
        targ.armortype = 0;
        targ.armorclass = 0;
        targ.items =
            targ.items -
            (targ.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
    }
    targ.armorvalue = targ.armorvalue - save;
    take = ceil(damage - save);

    if (targ.flags & FL_CLIENT) {
        targ.dmg_take = targ.dmg_take + take;
        targ.dmg_save = targ.dmg_save + save;
        targ.dmg_inflictor = inflictor;
    }
    if ((inflictor != world) && (targ.movetype == MOVETYPE_WALK)) {

        targ.immune_to_check = time + (damage / 20);
        dir = targ.origin - ((inflictor.absmin + inflictor.absmax) * 0.5);
        dir = normalize(dir);
        if (((damage < 60) &&
             ((attacker.classname == "player") &&
              (targ.classname == "player")))
            && (attacker.netname != targ.netname))
            targ.velocity = targ.velocity + dir * damage * 11;
        else
            targ.velocity = targ.velocity + dir * damage * 8;

        if (((rj > 1) &&
             ((attacker.classname == "player") &&
              (targ.classname == "player")))
            && (attacker.netname == targ.netname))
            targ.velocity = (targ.velocity + ((dir * damage) * rj));
    }
    if (targ.flags & FL_GODMODE)
        return;

    if (targ.invincible_finished >= time) {
        if (self.invincible_sound < time) {

            sound(targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
            self.invincible_sound = time + 2;
        }
        return;
    }
    if ((attacker.classname == "player")
        && ((targ.classname == "player") ||
            (targ.classname == "building_sentrygun"))) {

        if (((targ.team_no > 0) && (targ.team_no == attacker.team_no)) &&
            (targ != attacker)) {

            if (teamplay & TEAMPLAY_NOEXPLOSIVE)
                return;
            else if (teamplay & TEAMPLAY_HALFEXPLOSIVE)
                take = take / 2;
        }
    }
    if ((take < 1) && (take != 0))
        take = 1;

    targ.health = targ.health - take;

    if (targ.armorvalue < 1) {
        targ.armorclass = 0;
        targ.armorvalue = 0;
    }
    if (targ.health <= 0) {
        Killed(targ, attacker);
        return;
    }

    oldself = self;
    self = targ;

    if (self.th_pain) {
        self.th_pain(attacker, take);
        if (skill >= 3)
            self.pain_finished = time + 5;
    }
    self = oldself;
};

void (entity targ, entity inflictor, entity attacker, float damage,
      float T_flags, float T_AttackType) TF_T_Damage = {
    local vector dir;
    local entity oldself;
    local entity te;
    local float save;
    local float take;
    local float olddmsg;
    local float no_damage;
    local float moment;

    if (targ.takedamage == 0)
        return;

    if (T_AttackType & 256) {
        targ.health = damage;
        return;
    }
    if (cease_fire)
        return;

    no_damage = 0;


      if (targ.classname == "player")
      {
//         if (!cb_prematch)
//         {
            
            targ.dmg_recieved = targ.dmg_recieved + damage;
            if (targ.StatusBarSize)
                targ.StatusRefreshTime = (time + 0.100);

            if (attacker.classname == "player")
            {
               if (attacker == targ)
               {
                 attacker.dmg_self = attacker.dmg_self + damage;
                 if (attacker.StatusBarSize)
                     attacker.StatusRefreshTime = (time + 0.100);
               }
               else if (attacker.pteam.team == targ.pteam.team )
               {
                 attacker.dmg_team = attacker.dmg_team + damage;
                 if (attacker.StatusBarSize)
                     attacker.StatusRefreshTime = (time + 0.100);
               }
               else
               {
                 attacker.dmg_inflicted = attacker.dmg_inflicted + damage;
                 if (attacker.StatusBarSize)
                     attacker.StatusRefreshTime = (time + 0.100);
               }
            }
//         }
      }

    if (attacker.classname == "player") {

        damage = damage * 0.9;

        if (attacker.super_damage_finished > time)
            damage = damage * 4;

        if ((targ.classname != "player")
            && (targ.classname != "bot")
            && (targ.classname != "building_sentrygun")
            && (targ.classname != "building_dispenser")
            && (targ.classname != "building_teleporter_entrance")
            && (targ.classname != "building_teleporter_exit")) {

            if (!Activated(targ, attacker)) {
                if (targ.else_goal != 0) {
                    te = Findgoal(targ.else_goal);
                    if (te)
                        AttemptToActivate(te, attacker, targ);
                }
                return;
            }
        }
    }
    damage_attacker = attacker;

    if (teamplay & (TEAMPLAY_LESSSCOREHELP | TEAMPLAY_LESSPLAYERSHELP))
        damage = TeamEqualiseDamage(targ, attacker, damage);

    if ((targ.armorclass != 0) && (T_AttackType != 0)) {

        if ((targ.armorclass & AT_SAVESHOT) && (T_AttackType & TF_TD_SHOT)) {
            damage = floor(damage * 0.5);
        }
        if ((targ.armorclass & AT_SAVENAIL) && (T_AttackType & TF_TD_NAIL)) {
            damage = floor(damage * 0.5);
        }
        if ((targ.armorclass & AT_SAVEEXPLOSION) &&
            (T_AttackType & TF_TD_EXPLOSION)) {
            damage = floor(damage * 0.5);
        }
        if ((targ.armorclass & AT_SAVEELECTRICITY) &&
            (T_AttackType & TF_TD_ELECTRICITY)) {
            damage = floor(damage * 0.5);
        }
        if ((targ.armorclass & AT_SAVEFIRE) && (T_AttackType & TF_TD_FIRE)) {
            damage = floor(damage * 0.5);
        }
    }

    if (T_flags & TF_TD_IGNOREARMOUR) {

        take = damage;
        save = 0;

    } else {

        save = ceil(targ.armortype * damage);
        if ((attacker.classname == "player")
            && (targ.team_no > 0)
            && (targ.team_no == attacker.team_no)
            && (targ != attacker)
            && (T_flags & 2)) {

            if (T_AttackType & TF_TD_EXPLOSION) {

                if (teamplay & 1024) {
                    save = 0;
                } else if (teamplay & 512) {
                    save = save / 2;
                }

            } else if (teamplay & 256)
                save = 0;
            else if (teamplay & 128)
                save = save / 2;

        }
        if (save >= targ.armorvalue) {

            save = targ.armorvalue;
            targ.armortype = 0;
            targ.armorclass = 0;
            targ.items =
                targ.items -
                (targ.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));

        }
        targ.armorvalue = targ.armorvalue - save;
        take = ceil(damage - save);

    }
    if (targ.flags & FL_CLIENT) {

        targ.dmg_take = targ.dmg_take + take;
        targ.dmg_save = targ.dmg_save + save;
        targ.dmg_inflictor = inflictor;

    }
    if ((inflictor != world) && (targ.movetype == MOVETYPE_WALK) &&
        !(targ.tfstate & 65536)) {

        if (deathmsg != DMSG_GREN_NAIL) {

            targ.immune_to_check = time + damage / 20;
            dir =
                targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
            dir = normalize(dir);

            if (targ.playerclass == PC_HVYWEAP) {
                moment = damage / 4;
                if (damage <= 50)
                    moment = 0;
	    }
            else if (inflictor.volume)
              moment = damage * inflictor.volume; 
            else

                moment = damage;

            if ((moment < 60)
                && (attacker.classname == "player")
                && (targ.classname == "player")
                && (attacker.netname != targ.netname)) {

                targ.velocity = targ.velocity + dir * moment * 11;

            } else
                targ.velocity = targ.velocity + dir * moment * 8;

            if ((rj > 1) && (attacker.classname == "player")
                && (targ.classname == "player")
                && (attacker.netname == targ.netname)) {

                targ.velocity = targ.velocity + dir * moment * rj;
            }
        }
    }
    if (targ.flags & FL_GODMODE)
        return;

    if (targ.invincible_finished >= time) {
        if (self.invincible_sound < time) {
            sound(targ, 3, "items/protect3.wav", 1, 1);
            self.invincible_sound = time + 2;
        }
        return;
    }
    if ((attacker.classname == "player")
        && ((targ.classname == "player")
            || (targ.classname == "building_sentrygun")
            || (targ.classname == "building_dispenser")
            || (targ.classname == "building_teleporter_entrance")
            || (targ.classname == "building_teleporter_exit"))) {

        if ((targ.team_no > 0) && (targ.team_no == attacker.team_no)
            && (targ != attacker) && (T_flags & TF_TD_NOTTEAM)) {

            if (T_AttackType & TF_TD_EXPLOSION) {

                if (teamplay & TEAMPLAY_NOEXPLOSIVE)
                    no_damage = TRUE;
                else if (teamplay & TEAMPLAY_HALFEXPLOSIVE)
                    take = take / 2;

            } else if (teamplay & TEAMPLAY_NODIRECT)
                no_damage = TRUE;
            else if (teamplay & TEAMPLAY_HALFDIRECT)
                take = take / 2;
        }

    }


    if (targ.playerclass == PC_SPY) {
        targ.attacked_by = attacker;
        targ.feignmsg = deathmsg;
    }

    if (T_flags & TF_TD_NOTSELF)
        if (targ == attacker)
            return;

    if (take < 1)
        take = 1;

    take = rint(take);

    if (no_damage == 0)
        targ.health = (targ.health - take);

    if ((attacker.classname == "player")
        && ((targ.classname == "player")
            || (targ.classname == "building_sentrygun")
            || (targ.classname == "building_dispenser")
            || (targ.classname == "building_teleporter_entrance")
            || (targ.classname == "building_teleporter_exit"))) {

        if ((targ.team_no > 0) && (targ.team_no == attacker.team_no)
            && (targ != attacker) && (T_flags & 2)) {

            olddmsg = deathmsg;

            if (T_AttackType & TF_TD_EXPLOSION) {

                deathmsg = 37;
                if (teamplay & 16384)
                    TF_T_Damage(attacker, world, world, take, 1, 0);
                else if (teamplay & 8192)
                    TF_T_Damage(attacker, world, world, take / 2, 1, 0);

            } else {

                deathmsg = 37;
                if (teamplay & 4096)
                    TF_T_Damage(attacker, world, world, take, 1, 0);
                else if (teamplay & 2048)
                    TF_T_Damage(attacker, world, world, take / 2, 1, 0);
            }
            deathmsg = olddmsg;
        }
    }

    if (no_damage == TRUE)
        return;

    if (targ.armorvalue < 1) {
        targ.armorclass = 0;
        targ.armorvalue = 0;
    }

    if (targ.health <= 0) {

        if ((inflictor.classname == "detpack")
            && (inflictor.weaponmode == 1) && (inflictor.enemy == targ))
            deathmsg = DMSG_DETPACK_DIS;

        Killed(targ, attacker);
        return;
    }

    oldself = self;
    self = targ;

    if (self.th_pain) {
        self.th_pain(attacker, take);
        if (skill >= 3) {
            self.pain_finished = time + 5;
        }
    }
    self = oldself;
};

void (entity inflictor, entity attacker, float damage,
      entity ignore) T_RadiusDamage = {
    local float points;
    local entity head;
    local vector org;

    head = findradius(inflictor.origin, damage + 40);
    while (head) {
        if (head != ignore) {
            if (head.takedamage) {

                org = head.origin + (head.mins + head.maxs) * 0.5;
                points = 0.5 * vlen(inflictor.origin - org);
                if (points < 0)
                    points = 0;
                points = damage - points;
                if (head == attacker)
                    points = points * 0.75;

                if (points > 0) {
                    if (CanDamage(head, inflictor)) {
                        // shambler takes half damage from all explosions
                        if (head.classname == "monster_shambler")
                            T_Damage(head, inflictor, attacker,
                                     points * 0.5);
                        else
                            TF_T_Damage(head, inflictor, attacker, points,
                                        TF_TD_NOTTEAM, TF_TD_EXPLOSION);
                    }
                }
            }
        }
        head = head.chain;
    }
};

void (entity attacker, float damage) T_BeamDamage = {
    local float points;
    local entity head;

    head = findradius(attacker.origin, damage + 40);
    while (head) {
        if (head.takedamage) {

            points = 0.5 * vlen(attacker.origin - head.origin);
            if (points < 0)
                points = 0;
            points = damage - points;
            if (head == attacker)
                points = points * 0.5;
            if (points > 0)
                if (CanDamage(head, attacker))
                    T_Damage(head, attacker, attacker, points);
        }
        head = head.chain;
    }
};
