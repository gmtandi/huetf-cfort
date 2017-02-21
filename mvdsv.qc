void (float type, float print) SetOptCmd = {

   if (type == 1) {
     localcmd ("localinfo ");
   }
   else if (type == 2) {
     localcmd ("serverinfo ");
   }
   localcmd (argv(0));
   localcmd (" ");
   localcmd (argv(1));
   localcmd ("\n");

   if (print) {
      bprint(2, " ");
      bprint4(2, argv(0), " set to ", argv(1), " \n");
   }

};

void () ShowOptValue  = {

   local string tmp;

   tmp = infokey (world, argv(0));
   sprint(self,2, argv(0));
   sprint(self,2, " is \"");
   sprint(self,2, tmp);
   sprint(self,2, "\"\n");
};

float (string mode) CheckMode = {

   if (mode == "clan")		return 1;
   if (mode == "practice")	return 1;
   if (mode == "speedcap") 	return 1;
   if (mode == "duel") 		return 1;
   if (mode == "quadmode") 	return 1;
   if (mode == "teamfrags") 	return 1;
   if (mode == "fullteamscore") return 1;
   if (mode == "grapple") 	return 1;
   if (mode == "gibs") 		return 1;

    return 0;
};


float () UserCmd =
{

	local float arg_num, fl, adminlvl;
	local string st;

	arg_num = argc(); // text has been tokanized in ChatMessage function

	if (arg_num == 0)
		return 0;

/*  debug
		if (argv(0) == "test")
            {
			sprint(self, 2, "whazzup\n");
		      return 1;
		}

            //fte alpha test
		else if (argv(0) == "alpha")
            {
               if (arg_num == 2) {

                  fl = stof(argv(1));
                  if (fl >= 0 && fl <= 1) {
                     self.alpha = fl;
                  }
		      return 1;
               }
            }
		if (argv(0) == "gravity")
            {
               if (arg_num == 2) {

                  fl = stof(argv(1));
                  if (fl >= 0 && fl <= 4) {
                     self.gravity = fl;
                  }
		      return 1;
               }
            }
		else if (argv(0) == "colormap")
            {
			self.colormap = stof(argv(1));
		      return 1;
		}
*/
		else if (argv(0) == "sbar_type")
            {

               if (arg_num == 2) {

                  fl = stof(argv(1));
                  if (fl >= 0 && fl < 64) {
                     self.StatusRefreshTime = (time + 0.5);
			   self.sbar_type = fl;
                  }
		      return 1;
               }

		   if (arg_num == 1) {
			sprint(self, 2, "usage: cmd sbar_type \"value\", where value is the sbar type\n");
			sprint(self, 2, "\n");
			return 1;
		   }
		}
		else if (argv(0) == "dlist")
            {



               stuffcmd(self, "cmd demolist");

		   if (arg_num == 2) {

                 stuffcmd(self, " ");
                 stuffcmd(self, argv(1));

               }
		  
               stuffcmd(self, "\n");
		   return 1; 


		}
		else if (argv(0) == "dl")
            {


               if (arg_num == 2) {


                  stuffcmd(self, "cmd download demonum/");
                  stuffcmd(self, argv(1));
                  stuffcmd(self, "\n");
		      return 1;
 
               }

		   if (arg_num == 1) {
			sprint(self, 2, "type: cmd dlist, for a list of available demos\n");
			sprint(self, 2, "to download, type: cmd dl #, where # is the demo number\n");
			sprint(self, 2, "\n");
			return 1;
		   }


		}
		else if (argv(0) == "adminpwd")
            {


               if (arg_num == 2) {

	            if ((self.is_admin == 3.000)) {
		         sprint(self, 2, "You are already an admin\n");
		         return 1;
	            }
                  if(self.is_admin == 2.000) {
		         sprint(self, 2, "You cannot input password while electing.\n");
		         return 1;
	            }

                  Admin_Check(argv(1));

                  if (self.is_admin == 3.000) {
                     Admin_Aliases();
			   bprint2(2, self.netname, " çáéîó æõìì áäíéî óôáôõó!");
			   bprint(3, "\n");
			   sprint(self, 2, "Type ãïííáîäó for admin commands.\n");
                  } else {
			   sprint(self, 2, "incorrect admin password\n");
                  }
      	      return 1;
 
               }

		   if (arg_num == 1) {
			sprint(self, 2, "usage: cmd adminpwd password, where password is the admin password\n");
			sprint(self, 2, "\n");
			return 1;
		   }
            }
		else if (argv(0) == "maplist")
            {

		   if (arg_num == 1) {
                  fl = 1;
                  fl = listmaps(self, 2.000, 50, fl, 3, 1);
		      return 1;
		   }

            }
		else if (argv(0) == "votemap")
            {

               if (arg_num == 2) {


                  st = argv(1);

                  fl = findmap(st);
                  if (fl) {
                     st = findmapname(fl); //argv(1);
//                     PlayerMiscVote(st, 1);
                  } else {
 			   sprint(self, 2, "map name not found.\n");
                  }

Vote_Force_Start();


                  return 1;
               }

		   if (arg_num == 1) {
                  fl = 1;
//                  fl = listmaps(self, 2.000, 50, fl, 3, 1);
//                  stuffcmd(self, "\n");
Vote_Force_Start();
		      return 1;
		   }

            }
		else if (argv(0) == "votemode")
            {

               if (arg_num == 2) {

                  st = argv(1);
// _OZTF                  if (CheckMode(st))
// _OZTF                     PlayerMiscVote(st, 2);

                  return 1;
               }

		   if (arg_num == 1) {

		      return 1;
		   }

            }
		else if (argv(0) == "abort")
            {


		   if (arg_num == 1) {

//	            if(self.mvote) {
//	            	bprint2(2, self.netname, " ÷éôèäòá÷ó ");
//		            if(infokey(self, "gender") == "f") bprint(2, "èåò ");
//		            else bprint(2, "èéó ");
//		            bprint(3, "vote\n");
//		            v_misc = v_misc - 1;
// _OZTF                        if (self.mvote == 2.000) AbortMiscVote ();
//		            self.mvote = 0;
//		            return 1;
//	            } else {
                     
                     sprint(self,2 , "There are no current votes active.\n");
                     return 1;
//                  }
		   }

            }
      	else if (argv(0) == "keep")
            {
               if (arg_num == 5) {

                  st = argv(1);
                  fl = stof(st);
                  fl = self.ammo_shells - fl;
// _OZTF                  if (fl > 0) TeamFortress_DropAmmo( 1.000, fl);


                  st = argv(2);
                  fl = stof(st);
                  fl = self.ammo_nails - fl;
// _OZTF                  if (fl > 0) TeamFortress_DropAmmo( 2.000, fl);


                  st = argv(3);
                  fl = stof(st);
                  fl = self.ammo_rockets - fl;
// _OZTF                  if (fl > 0) TeamFortress_DropAmmo( 3.000, fl);

                  st = argv(4);
                  fl = stof(st);
                  fl = self.ammo_cells - fl;
// _OZTF                  if (fl > 0) TeamFortress_DropAmmo( 4.000, fl);

                  return 1;

               }
               if (arg_num == 3) {

                  if (argv(1) == "shells" || argv(1) == "1")
                  {
                     st = argv(2);
                     fl = stof(st);
                     fl = self.ammo_shells - fl;
// _OZTF                     if (fl > 0) TeamFortress_DropAmmo( 1.000, fl);
                     return 1;
                  }
                  else if (argv(1) == "nails" || argv(1) == "2")
                  {
                     st = argv(2);
                     fl = stof(st);
                     fl = self.ammo_nails - fl;
// _OZTF                     if (fl > 0) TeamFortress_DropAmmo( 2.000, fl);
                     return 1;
                     
                  }
                  else if (argv(1) == "rockets" || argv(1) == "3")
                  {
                     st = argv(2);
                     fl = stof(st);
                     fl = self.ammo_rockets - fl;
// _OZTF                     if (fl > 0) TeamFortress_DropAmmo( 3.000, fl);
                     return 1;
                     
                  }
                  else if (argv(1) == "cells" || argv(1) == "4")
                  {
                     st = argv(2);
                     fl = stof(st);
                     fl = self.ammo_cells - fl;
// _OZTF                     if (fl > 0) TeamFortress_DropAmmo( 4.000, fl);
                     return 1;
                  }

               }

		   if (arg_num < 3) {
	            sprint(self, 2, "usage: cmd keep cells #value, to keep ammo that you specify and discard the rest.\n");
		      sprint(self, 2, "\n");
			return 1;
		   }

            }
		else if (argv(0) == "eprint")
            {
			eprint(self);
		      return 1;
		}
		else if (argv(0) == "help" || argv(0) == "list"  )
            {

               if (arg_num == 2) {

                  if (argv(1) == "adminpwd")
                  {
   			   sprint(self, 2, "usage: cmd adminpwd password, where password is the admin password\n\n");
			   return 1;
		      }
			else  if (argv(1) == "dl")
                  {
   			   sprint(self, 2, "usage: to download a demo off the server\ntype: cmd dl #, where # is the demo number\n\n");
			   return 1;
                  }
			else  if (argv(1) == "dlist")
                  {
   			   sprint(self, 2, "usage: a list of available demos on the server\n\n");
			   return 1;
                  }
			else  if (argv(1) == "demolist")
                  {
   			   sprint(self, 2, "usage: a list of available demos on the server\n\n");
			   return 1;
                  }
			else  if (argv(1) == "maplist")
                  {
   			   sprint(self, 2, "usage: a list of available maps on the server\n\n");
			   return 1;
                  }
			else  if (argv(1) == "votemap")
                  {
   			   sprint(self, 2, "usage: vote to change the current map\n\n");
			   return 1;
                  }
			else  if (argv(1) == "votemode")
                  {
   			   sprint(self, 2, "usage: vote to enable a mode ie. cmd votemode clan\n\n");
			   return 1;
                  }
                  if (self.is_admin == 3.000)
                  {

			   if (argv(1) == "timelimit")
                     {
   			      sprint(self, 2, "usage: cmd timelimit \"time\", sets a timelimit on the server\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "prematch")
                     {
   			      sprint(self, 2, "usage: cmd prematch \"time\", to change the current pre-match time \n\n");
			      return 1;
                     }
			   else  if (argv(1) == "fraglimit")
                     {
   			      sprint(self, 2, "usage: cmd fraglimit \"frags+caps\", sets a fraglimit on the server\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "overtime")
                     {
   			      sprint(self, 2, "usage: cmd overtime \"time\", sets the match overtime\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "cft")
                     {
   			      sprint(self, 2, "usage: cmd cft \"time\", to change the current ceasefire time\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "password")
                     {
   			      sprint(self, 2, "usage: cmd password \"password\", sets a client password on the server\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "spec_password")
                     {
   			      sprint(self, 2, "usage: cmd spec_password \"password\", sets a spectator password on the server\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "password")
                     {
   			      sprint(self, 2, "usage: cmd map \"mapname\", changes the current map\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "record")
                     {
   			      sprint(self, 2, "usage: cmd record \"demoname\", records a server multi-view-demo\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "easyrecord")
                     {
   			      sprint(self, 2, "usage: cmd easyrecord, records a server demo without naming convention\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "autorecord")
                     {
   			      sprint(self, 2, "usage: cmd autorecord, toggles autorecording on, which records\n a server demo automatically when a match countdown begins\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "cancel")
                     {
   			      sprint(self, 2, "usage: cmd cancel, cancels the current server demo, and deletes it.\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "stop")
                     {
   			      sprint(self, 2, "usage: cmd stop, stops recording the current server demo\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "maxclients")
                     {
   			      sprint(self, 2, "usage: cmd maxclients \"clients\", limits the maximum\n amount of players in the server.\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "maxspectators")
                     {
   			      sprint(self, 2, "usage: cmd maxspectators \"specs\", limits the maximum\n amount of spectators in the server.\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "deal")
                     {
   			      sprint(self, 2, "usage: cmd deal, cycles the kick procedure to \n kick a player from the server.\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "kick")
                     {
   			      sprint(self, 2, "usage: cmd kick \"value\", kick a player from the server.\n\n");
			      return 1;
                     }
			   else  if (argv(1) == "rpickup")
                     {
   			      sprint(self, 2, "usage: cmd rpickup, randomises player teams.\n\n");
			      return 1;
                     }
                  }

               } 

               if (arg_num == 1)
               {

                  sprint(self, 2, "Commands list:\ncmd adminpwd\ncmd dl\ncmd dlist or demolist\ncmd maplist\ncmd votemap\ncmd votemode\ncmd keep \"ammo\" \"value\"\n");
	        
                  if (self.is_admin == 3.000) {

                     sprint(self, 2, "cmd timelimit\ncmd watervis\ncmd prematch\ncmd fraglimit\ncmd teamplay\ncmd overtime\ncmd cft\ncmd password\ncmd spec_password\n");
                     sprint(self, 2, "cmd map\ncmd record\ncmd easyrecord\ncmd autorecord\ncmd cancel\ncmd stop\ncmd quadmode\ncmd teamname\ncmd maxclients\ncmd maxspectators\n");
                  //sprint(self, 2, "cmd observermode\n");
                     sprint(self, 2, "cmd deal\ncmd kick\ncmd rpickup\ncmd cr_\"classname\"\ncmd powerups\ncmd spec_msgs\n");
                     //sprint(self, 2, "");
                  }

                  sprint(self, 2, "cmd help or list (this command)\nFor more info on a command, type cmd help \"command\"\n\n");
		      return 1;
               }
            }
             


     adminlvl = stof(infokey(world, "adminlevel"));
     if ((self.is_admin == 3.000) || ((self.is_admin == 1.000) && (adminlvl >= 1)))
     {
            if (argv(0) == "timedown")
            {
// _OZTF            	TimeDown (5);
	      	return 1;
            } 
            else if (argv(0) == "timeup")
            {
// _OZTF                  TimeUp (5);
	            return 1;				  
            }
            else if (argv(0) == "pmdown")
            {
// _OZTF                  MiscTimeDown (1, "prematch");
	            return 1;
            } 
            else if (argv(0) == "pmup")
            {
// _OZTF                  MiscTimeUp (1, "prematch");
	            return 1;					  
            }
            else if (argv(0) == "cfdown")
            {
// _OZTF                  MiscTimeDown (1, "cft");
	            return 1;
            } 
   		else if (argv(0) == "cfup")
   		{	    
// _OZTF         		MiscTimeUp (1, "cft");
	            return 1;				  
   		}
   		else if (argv(0) == "otdown")
   		{
// _OZTF         		MiscTimeDown (1, "overtime");
	            return 1;
   		} 
   		else if (argv(0) == "otup")
   		{
// _OZTF         		MiscTimeUp (1, "overtime");
	            return 1;				  
   		}
   		else if (argv(0) == "startmatch")
  		{
// _OZTF        		if (CheckClanMode()) return 1;
         		pmtime = 0.000;
// _OZTF         		StartTimer();
	            return 1;                                  
   		} 
  		else if (argv(0) == "fragsdown")
   		{
// _OZTF        		FragLimit(-10);
	            return 1;
   		} 
   		else if (argv(0) == "fragsup")
   		{
// _OZTF         		FragLimit(10);
	            return 1;
   		} 
		else if (argv(0) == "powerups")
            {
// _OZTF            	TogglePowerups();
            	return 1;
            }
		else if (argv(0) == "rpickup")
            {
// _OZTF                  RandomPickup();
                  return 1;
            }
		else if (argv(0) == "spec_msgs")
            {
// _OZTF            	ToggleSpecMsgs();
            	return 1;
            }
            else if (argv(0) == "countplayers")
            {
// _OZTF                  Admin_CountPlayers ();
	            return 1;             
            }
  		else if (argv(0) == "restartmap")
   		{
// _OZTF         		RestartMap ();
      		return 1;
   		}
   		else if (argv(0) == "teamfrags")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		} 
   		else if (argv(0) == "fullts")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "grapple")
   		{
// _OZTF         		Toggle_Misc (argv(0));
     			return 1;
   		}
   		else if (argv(0) == "gibs")
   		{ 	 
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;   
   		}
  		else if (argv(0) == "silence")
   		{
// _OZTF         		ToggleSpecTalk();
      		return 1;
   		} 

	}

      if (((self.is_admin == 1.000) && (adminlvl >= 2)) || (self.is_admin == 3.000))
      {
		if (argv(0) == "quadmode")
            {
// _OZTF            	Toggle_Quad();
            	return 1;
            }
   		else if (argv(0) == "clan")
  		{
// _OZTF         		Toggle_Misc (argv(0));
     			return 1;
   		}
   		else if (argv(0) == "tfvsdm")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "practice")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "speedcap")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "duel")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "rounds")
   		{
//rounds 2 argv
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
  		else if (argv(0) == "tfstrike")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "reset")
   		{
// _OZTF         		if (CheckClanMode()) return 1;
// _OZTF         		ResetSetup();
      		return 1;
   		}
   		else if (argv(0) == "clansetup")
   		{
// _OZTF         		if (CheckClanMode()) return 1;
// _OZTF         		ClanSetup(); 
      		return 1;
   		}
  		else if (argv(0) == "ceasefire")
   		{
// _OZTF      		Admin_CeaseFire ();
      		return 1;                
   		}
   		else if (argv(0) == "freeze")
   		{
// _OZTF      		if (CheckClanMode()) return 1;
// _OZTF      		ToggleFreeze();
      		return 1;
   		}  
  		else if (argv(0) == "highlander")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "tp")
   		{
// _OZTF         		if (CheckClanMode()) return 1;
// _OZTF         		ChangeTP ();
      		return 1;
  		} 
   		else if (argv(0) == "gspeed")
   		{
// _OZTF         		if (CheckClanMode()) return 1;	 
// _OZTF        		GroundSpeed ();
      		return 1;										   
   		} 
   		else if (argv(0) == "grenpacks")
   		{
// _OZTF         		if (CheckClanMode()) return 1;	 
// _OZTF         		Toggle_Grenpacks();
      		return 1;
  		}
   		else if (argv(0) == "fbskins")
   		{
// _OZTF         		if (CheckClanMode()) return 1; 	 
// _OZTF         		ToggleFbskins(); 
      		return 1;
   		} 
   		else if (argv(0) == "enemy")
   		{
// _OZTF         		if (CheckClanMode()) return 1; 	 
// _OZTF         		ToggleEnemy(); 
      		return 1;
   		} 
  		else if (argv(0) == "pointing")
   		{
// _OZTF         		if (CheckClanMode()) return 1; 	 
// _OZTF         		TogglePointing(); 
      		return 1;
   		}
   		else if (argv(0) == "soliddp")
   		{
// _OZTF      		if (CheckClanMode()) return 1; 	 
// _OZTF      		Toggle_Detpack(); 
      		return 1;
   		} 
   		else if (argv(0) == "flag_model")
  		{
// _OZTF         		Toggle_flag_emu(); 
     			return 1;
   		}
   		else if (argv(0) == "flag_solid")
   		{
// _OZTF         		Toggle_Misc (argv(0));
      		return 1;
   		}
   		else if (argv(0) == "flag_drop")
		{
// _OZTF         		Toggle_Misc (argv(0));
		      return 1;
		}
		else if (argv(0) == "sgtype")
   		{
// _OZTF      		if (CheckClanMode()) return 1;
// _OZTF      		Toggle_SentryType ();
      		return 1;
   		}
   		else if (argv(0) == "sgfire")
   		{
// _OZTF         		if (CheckClanMode()) return 1;
// _OZTF         		Toggle_SentryFire ();
      		return 1;
   		}
   		else if (argv(0) == "pipedelay")
   		{
// _OZTF         		Toggle_PipeDelay  ();
      		return 1;
   		}
   		else if (argv(0) == "frjump")
   		{
// _OZTF		      Toggle_Frj ();
      		return 1;
   		}
            else if (argv(0) == "timelimit")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "watervis")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "prematch")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "fraglimit")
            {
               if (arg_num == 2) {
                  SetOptCmd(0,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "teamplay")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "overtime")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cft")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
      	   }
            }
		else if (argv(0) == "record")
            {

               if (arg_num == 2) {
                  SetOptCmd(3,0);
                  return 1;
               }

		   if (arg_num == 1) {
	            sprint(self, 2, "usage: cmd record demo, where demo is the demo name\n");
		      sprint(self, 2, "\n");
			return 1;
		   }

            }
		else if (argv(0) == "easyrecord")
            {

                 if (arg_num == 2) {
                  SetOptCmd(3,0);
                  return 1;
                 }

                 if (arg_num == 1) {

                    localcmd("easyrecord\n");
                    return 1;
                 }
            }
            else if (argv(0) == "autorecord")
            {
               if (arg_num == 2) {

                  localcmd ("localinfo demo_auto_left ");
                  localcmd (argv(1));
                  localcmd ("\n");
                  return 1;
               }

               if (arg_num == 1) {

                  st = infokey (world, "demo_auto_left");

                  if (stof (st) > 0) {
                     bprint(2.000, "Auto-Recording off\n");
                     localcmd ("localinfo demo_auto_left 0\n");
	               return 1;

	            } else {

                     bprint(2.000, "Auto-Recording the next match\n");
                     localcmd ("localinfo demo_auto_left 1\n");
	               return 1;

                  }
               }
	      }
		else if (argv(0) == "cancel")
            {
                 localcmd("cancel\n");
                 return 1;
            }
		else if (argv(0) == "stop")
            {
                 localcmd("stop\n");
                 return 1;
            }

/*
            else if (argv(0) == "observermode")
            {

               Toggle_Observer ();
               return 1;
            }
*/
      	else if (argv(0) == "teamname")
            {

               if (arg_num == 5) {

                  localcmd ("serverinfo team1 ");
                  localcmd (argv(1));
                  localcmd ("\n");

                  localcmd ("serverinfo team2 ");
                  localcmd (argv(2));
                  localcmd ("\n");

                  localcmd ("serverinfo team3 ");
                  localcmd (argv(3));
                  localcmd ("\n");

                  localcmd ("serverinfo team4 ");
                  localcmd (argv(4));
                  localcmd ("\n");
               }

               if (arg_num == 3) {

                  fl = stof(argv(1));

		      if (fl > 0 && fl < 5) {

			   localcmd("serverinfo team");
                     localcmd(ftos(fl));
                     localcmd(" ");
                     localcmd(argv(2));
                     localcmd("\n");

                  } else {
                      localcmd ("serverinfo team1 ");
                      localcmd (argv(1));
                      localcmd ("\n");

                      localcmd ("serverinfo team2 ");
                      localcmd (argv(2));
                      localcmd ("\n");

                  }

               }
               return 1;
            }
      	else if (argv(0) == "maxclients")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,1);
                  return 1;
               }

		   if (arg_num == 1) {
                  ShowOptValue ();
	            //sprint(self, 2, "usage: cmd maxclients clients, where clients is the maximum number of players name you wish join the game.\n");
		      //sprint(self, 2, "\n");
			return 1;
		   }

            }
      	else if (argv(0) == "maxspectators")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,1);
                  return 1;
               }

		   if (arg_num == 1) {
                  ShowOptValue ();
	            //sprint(self, 2, "usage: cmd maxspectators specs, where specs is the maximum number of spectators name you wish to observe.\n");
		      //sprint(self, 2, "\n");
			return 1;
		   }

            }
		else if (argv(0) == "map")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,0);
                  return 1;
               }

		   if (arg_num == 1) {
	            sprint(self, 2, "usage: cmd map mapname, where mapname is the map name you wish to change to\n");
		      sprint(self, 2, "\n");
			return 1;
		   }

            }
            else if (argv(0) == "dmteams")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {

                  ShowOptValue ();
	            return 1;
	         }
            }


	}
      if (((self.is_admin == 1.000) && (adminlvl >= 3)) || (self.is_admin == 3.000))
      {
		if (argv(0) == "next")
            {
      		if (self.admin_mode == 1.000)
// _OZTF         		Admin_CycleDeal ();
      		return 1;
		}
		else if (argv(0) == "deal")
            {
// _OZTF               Admin_CycleDeal();
               return 1;
            }
		else if (argv(0) == "kick")
            {
               if (arg_num == 2) {
// _OZTF                  Admin_KickNum(stof(argv(1)));
                  return 1;
               }

               if (arg_num == 1)
               {
                  if (self.admin_mode == 1.000)
                  {
// _OZTF                     Admin_DoKick ();
                     return 1;
                  }

// _OZTF                  Admin_ListPlayers();
                  return 1;
               }
            }
		else if (argv(0) == "password")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,0);

// _OZTF		      PrintPlayers("\nServer Password changed to \"", argv(1), "\"\n\n");
                  if (self.classname == "observer") 
	               sprint3(self, 2, "\nServer Password changed to \"", argv(1), "\"\n");
                  return 1;
               }

		   if (arg_num == 1) {
	            sprint(self, 2, "usage: cmd password \"password\"\n");
		      sprint(self, 2, "\n");
			return 1;
		   }
		   

            }
		else if (argv(0) == "spec_password")
            {

               if (arg_num == 2) {
                  localcmd ("spectator_password ");
                  localcmd (argv(1));
                  localcmd ("\n");

// _OZTF		      PrintSpecs("\nSpectator Password changed to \"", argv(1), "\"\n");
                  if (self.classname == "player") 
	               sprint3(self, 2, "\nSpectator Password changed to \"", argv(1), "\"\n");
                  return 1;
               }

		   if (arg_num == 1) {
	            sprint(self, 2, "usage: cmd spec_password \"password\"\n");
		      sprint(self, 2, "\n");
			return 1;
		   }
		   

            }
            else if (argv(0) == "cr_scout")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_sniper")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_soldier")
            {
               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_demoman")
            {
               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_medic")
            {
               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_hwguy")
            {
               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_pyro")
            {
               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_spy")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_engineer")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "cr_random")
            {

               if (arg_num == 2) {
                  SetOptCmd(1,1);
                  return 1;
               }

               if (arg_num == 1) {
                  ShowOptValue ();
	            return 1;
	         }
            }
            else if (argv(0) == "floodprot")
            {

               if (arg_num > 2) 
               {
 		      sprint(self, 2, "Ensure you use quotations around value - ie cmd floodprot \"8 4 2\"\n");
                  return 1;
               }

               if (arg_num == 2) {
                  SetOptCmd(0,0);
                  return 1;
               }

               if (arg_num == 1) { 
// _OZTF                  st = readcmd (st);
		      sprint(self, 2, st);
	            return 1;
	         }
            }
            else if (argv(0) == "rmdemo")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,0);
                  return 1;
               }

               if (arg_num == 1) {
// _OZTF                  st = readcmd (st);
/*
	            sprint(self, 2, "usage: rmdemo <demoname> - removes the demo\n");
	            sprint(self, 2, "       rmdemo *<token>   - removes demo with <token> in the name\n");
	            sprint(self, 2, "       rmdemo *          - removes all demos\n");
		      sprint(self, 2, "\n");
*/
		      sprint(self, 2, st);
	            return 1;
	         }
            }
            else if (argv(0) == "rmdemonum")
            {

               if (arg_num == 2) {
                  SetOptCmd(0,0);
                  return 1;
               }

               if (arg_num == 1) {
// _OZTF                  st = readcmd (st);
		      sprint(self, 2, st);
	            //sprint(self, 2, "usage: rmdemonum <#> - removes the demo of the number specified\n");
		      //sprint(self, 2, "\n");
	            return 1;
	         }
            }
   		else if (argv(0) == "calibrate")
   		{
// _OZTF      		Calibrate_Level();
      		return 1;
   		}
		else if (argv(0) == "listips")
   		{
// _OZTF         		Admin_ListIPs ();
      		return 1;
   		} 

	
      }
    return 0;
};



float () ConsoleCmd = {

   local string tmp;
   local float arg_num, fl;


	arg_num = argc(); // tmp has been tokanized in ChatMessage function

	if (arg_num == 0)
		return 0;


      if (argv(0) == "test")
      {
		dprint("whazzup\n");
            return 1;
	}
      else if (argv(0) == "info")
      {

         if (arg_num == 3) {

            if (argv(2) == "\\")
            {

               localcmd("localinfo ");
               localcmd(argv(1));
               localcmd(" \"");
               localcmd("\"\n");

               dprint("localinfo ");
               dprint(argv(1));
               dprint(" removed");
               dprint("\n");
               return 1;
    
            }

            localcmd("localinfo ");
            localcmd(argv(1));
            localcmd(" ");
            localcmd(argv(2));
            localcmd("\n");
            return 1;
         }

         if (arg_num == 2) {
            tmp = infokey (world, argv(1));

            dprint("localinfo ");
            dprint(argv(1));
            dprint(": \"");
            dprint(tmp);
            dprint("\"\n");
            return 1;
         }

	   if (arg_num == 1) {

            localcmd ("localinfo\n");
		return 1;
         }

      }

      else if (argv(0) == "svinfo")
      {

         if (arg_num == 3) {

            if (argv(2) == "\\")
            {

               localcmd("serverinfo ");
               localcmd(argv(1));
               localcmd(" \"");
               localcmd("\"\n ");

               dprint("serverinfo ");
               dprint(argv(1));
               dprint(" removed");
               dprint("\n");
               return 1;
    
            }

            localcmd("serverinfo ");
            localcmd(argv(1));
            localcmd(" ");
            localcmd(argv(2));
            localcmd("\n");
            return 1;
         }

         if (arg_num == 2) {
            tmp = infokey (world, argv(1));

            dprint("serverinfo ");
            dprint(argv(1));
            dprint(": \"");
            dprint(tmp);
            dprint("\"\n");

            return 1;
         }

	   if (arg_num == 1) {

            localcmd ("serverinfo\n");
		return 1;
         }
      }
      else if (argv(0) == "prematch")
      {
         if (arg_num == 2) {
            SetOptCmd(1,0);
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, argv(0));

            dprint("prematch is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }
      else if (argv(0) == "overtime")
      {
         if (arg_num == 2) {
            SetOptCmd(1,0);
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, argv(0));

            dprint("overtime is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }
      else if (argv(0) == "cft")
      {
         if (arg_num == 2) {
            SetOptCmd(1,0);
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, argv(0));

            dprint("ceasefire time is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }
      else if (argv(0) == "gspeed")
      {
         if (arg_num == 2) {

// _OZTF            gspeed = stof(argv(1));

// _OZTF            if ((gspeed < 1) || (gspeed > 3 ))  {
// _OZTF               gspeed = 0.000;
// _OZTF               dprint("invalid value\n");
// _OZTF               return 1;
// _OZTF            }
            localcmd ("localinfo pm_gspeed ");
            localcmd (argv(1));
            localcmd ("\n");
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, "pm_gspeed");

            dprint("ground speed is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }
      else if (argv(0) == "airspeed")
      {
         if (arg_num == 2) {

// _OZTF            airspeed = stof(argv(1));

// _OZTF            if ((airspeed < 1) || (airspeed > 4 ))  {
// _OZTF               airspeed = 0.000;
// _OZTF               dprint("invalid value\n");
// _OZTF               return 1;
// _OZTF            }
            localcmd ("localinfo pm_airspeed ");
            localcmd (argv(1));
            localcmd ("\n");
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, "pm_airspeed");

            dprint("air speed is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }

      else if (argv(0) == "roundtime")
      {
         if (arg_num == 2) {

            localcmd ("localinfo round_time ");
            localcmd (argv(1));
            localcmd ("\n");
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, argv(0));

            dprint("round time is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }

      else if (argv(0) == "rounds")
      {
         if (arg_num == 2) {
            SetOptCmd(1,0);
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, argv(0));

            dprint("rounds is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
	      return 1;
	   }
      }
      else if (argv(0) == "autorecord")
      {
         if (arg_num == 2) {

            localcmd ("localinfo demo_auto_left ");
            localcmd (argv(1));
            localcmd ("\n");
            return 1;
         }

         if (arg_num == 1) {

            tmp = infokey (world, "demo_auto_left");

            if (stof (tmp) > 0) {
               dprint("Auto-Recording off\n");
               localcmd ("localinfo demo_auto_left 0\n");
	         return 1;

            } else {
               dprint("Auto-Recording the next match\n");
               localcmd ("localinfo demo_auto_left 1\n");
	         return 1;

            }
         }
      }
      else if (argv(0) == "grenradius")
      {
         if (arg_num == 2) {

// _OZTF            grenradius = stof(argv(1));
       
// _OZTF            if (grenradius > 32 || grenradius < 0)
// _OZTF            {
// _OZTF               grenradius = 0;
// _OZTF            }
// _OZTF            return 1;
         }

         if (arg_num == 1) {
            tmp = infokey (world, argv(0));
            dprint("grenradius is ");
            dprint("\"");
            dprint(tmp);
            dprint("\"\n");
            return 1;
         }

      }
      else if (argv(0) == "restartmap")
      {
// _OZTF         RestartMap();
         return 1;
      }
      else if (argv(0) == "startmatch")
      {

// _OZTF         fl = TeamFortress_NoTeams(); 

         if (fl < 1.000) {

	      dprint("No teams in game\n");
	      dprint("Match cannot be started.\n");
            return 1;
         }

         pmtime = 0.000;
         
// _OZTF         StartTimer();
         return 1;
      }
      else if (argv(0) == "break")
      {
         pmtime = 0.000;
// _OZTF         StopTimer();
         return 1;
      }
      else if (argv(0) == "clan")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "tfvsdm")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "practice")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "tfstrike")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "duel")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "teamfrags")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "fullteamscore")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "clansetup")
      {
// _OZTF         ClanSetup ();
         return 1;
      }
      else if (argv(0) == "reset")
      {
// _OZTF         ResetSetup ();
         return 1;
      }
      else if (argv(0) == "fbskins")
      {
// _OZTF         ToggleFbskins();
         return 1;
      }
      else if (argv(0) == "frj")
      {
// _OZTF         Toggle_Frj();
         return 1;
      }
      else if (argv(0) == "silence")
      {
// _OZTF         ToggleSpecTalk();
         return 1;
      }
      else if (argv(0) == "grapple")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "ceasefire")
      {
// _OZTF         Admin_CeaseFire ();
         return 1;
      }
      else if (argv(0) == "freeze")
      {
// _OZTF         ToggleFreeze ();
         return 1;
      }
      else if (argv(0) == "speedcap")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "flag_model")
      {
// _OZTF         Toggle_flag_emu ();
         return 1;
      }
      else if (argv(0) == "grenpacks")
      {
// _OZTF         Toggle_Grenpacks  ();
         return 1;
      }
      else if (argv(0) == "gibs")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "highlander")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "real_weap")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "stamina")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "plasmaclass")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "forzamode")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "lights")
      {
// _OZTF         Toggle_Lighting();
         return 1;
      }
      else if (argv(0) == "detpack")
      {
// _OZTF         Toggle_Detpack ();
         return 1;
      }
      else if (argv(0) == "pipedelay")
      {
// _OZTF         Toggle_PipeDelay ();
         return 1;
      }
      else if (argv(0) == "sgfire")
      {
// _OZTF          Toggle_SentryFire();
         return 1;
      }
      else if (argv(0) == "sgtype")
      {
// _OZTF         Toggle_SentryType ();
         return 1;
      }
      else if (argv(0) == "quadmode")
      {
// _OZTF         Toggle_Quad ();
         return 1;
      }
/*
      else if (argv(0) == "observermode")
      {
         Toggle_Observer ();
         return 1;
      }
*/
      else if (argv(0) == "realdm")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "holdlimit")
      {
// _OZTF         Toggle_Misc(argv(0));
         return 1;
      }
      else if (argv(0) == "time")
      {
// _OZTF         calltimeofday();
         return 1;
      }

      else if (argv(0) == "commands")
      {

         dprint("oztf commands added:\n--------------------------\n");
         dprint("prematch\novertime\nrounds\nroundtime\ncft\ngspeed\nairspeed\ninfo\nsvinfo\npassword\nautorecord\nrestartmap\nstartmatch\nbreak\nclan\n");
         dprint("practice\ntfstrike\ntfvsdm\nduel\nteamfrags\nfullteamscore\nreset\nclansetup\nfbskins\nfrj\nsilence\ngrapple\nceasefire\nfreeze\n");
         dprint("speedcap\nflag_model\ngrenpacks\ngibs\nhighlander\nlights\ndetpack\npipedelay\ngrenradius\nsgfire\nsgtype\ntime\nquadmode\nrealdm\n");
         dprint("holdlimit\ncommands\n---------------------\n45 Commands\n");
         return 1;
      }
      return 0;



};


float () localinfoChanged = {

   local string tmp;
   local float fl;
   local float arg_num;


	arg_num = argc(); // tmp has been tokanized in ChatMessage function

	if (arg_num == 0)
		return 0;

      if (argv(1) == "gay") {
         dprint("you are gay\n");
         return 0;
      }

      else if (argv(1) == "rj")
      {

         if ( (stof (argv(1)) != 0.000) ) {
            rj = stof (infokey (world,"rj"));
         } else {
            rj = 1.000;
         }
         return 1;
      }
      else if (argv(1) == "gravity")
      {
         tmp = argv(1);
         fl = stof(tmp);
     
         if (fl > 2000 || fl < 0)
         {
            fl = 800;
         }
         cvar_set ("sv_gravity",ftos(fl));
         return 1;
      }
      else if (argv(1) == "friction")
      {
         tmp = argv(1);
         fl = stof(tmp);
     
         if (fl > 99 || fl < 0)
         {
            fl = 6;
         }
         cvar_set ("sv_friction",ftos(fl));
         return 1;
      }

      else if (argv(1) == "waterfriction")
      {
         tmp = argv(1);
         fl = stof(tmp);
     
         if (fl > 99 || fl < 0)
         {
            fl = 1;
         }
         cvar_set ("sv_waterfriction",ftos(fl));
         return 1;
      }


      dprint(argv(0));
      dprint(" ");
      dprint(argv(1));
      dprint(" ");
      dprint(argv(2));
      dprint("\n");

      return (1.000);
};

void () UserInfo_Changed = {

   local string sk, st;
   local float arg_num, tc;


	arg_num = argc(); // tmp has been tokanized in ChatMessage function

	if (arg_num == 0)
		return;

      if (argv(1) == "team")
      {

         if ( (teamplay) ) {

            if (self.motd > 65.000) {

 
               st = self.pteam.netname;
               if ( (st != infokey (self,"team")) ) {

                  SetTeamName (self);
               }
            }
         }

   
         return;
      }
/*      else if (argv(1) == "skin")
      {

         if ( (self.playerclass) ) {

            st = infokey (self,"skin");
            tc = 0.000;
            sk = TeamFortress_GetSkin (self);
            if ( (st != sk) ) {

               TeamFortress_SetSkin (self);
            }
         }

         return;
      }
      else if (argv(1) == "bottomcolor")
      {

        if (teamplay) {
         st = infokey (self,"bottomcolor");
         tc = stof (st);

         if ( ((self.playerclass == 8.000) && (self.undercover_team != 0.000)) ) {

            if ( ((PTeamGetColor (self.undercover_team) ) != tc) ) {

               stuffcmd (self,"color ");
               tc = (PTeamGetColor (self.undercover_team) );
               st = ftos (tc);
               stuffcmd (self,st);
               stuffcmd (self,"\n");

            }

         } else {

            if (tc != (self.pteam.colormap)) {

               stuffcmd (self,"color ");
               st = ftos (self.pteam.colormap);
               stuffcmd (self,st);
               stuffcmd (self,"\n");
            }
         }    
        }
         return;

      }
      else if (argv(1) == "topcolor")
      {
 
         if (teamplay && self.playerclass) {

            if (self.undercover_team) return;

            if (store_obs.cnt == 2.000)
            {

               if (self.pteam == pteam1)
               {
                  if (argv(2) == "4")
                  {
                     sprint(self,2.000,"You cannot use another teams colour as your topcolor.\n");
                     stuffcmd (self,"topcolor ");
                     st = ftos(self.pteam.colormap);
                     stuffcmd (self,st);
                     stuffcmd (self,"\n");
                     return;
                  }
               } 
               else if (self.pteam == pteam2)
               {
                  if (argv(2) == "13")
                  {
                     sprint(self,2.000,"You cannot use another teams colour as your topcolor.\n");
                     stuffcmd (self,"topcolor ");
                     st = ftos(self.pteam.colormap);
                     stuffcmd (self,st);
                     stuffcmd (self,"\n");
                     return;
                  }
               }
            }

            if (store_obs.cnt == 4.000)
            {

               if (self.pteam == pteam1)
               {
                  if (argv(2) == "4" || argv(2) == "12" || argv(2) == "11")
                  {
                     sprint(self,2.000,"You cannot use another teams colour as your topcolor.\n");
                     stuffcmd (self,"topcolor ");
                     st = ftos(self.pteam.colormap);
                     stuffcmd (self,st);
                     stuffcmd (self,"\n");
                     return;
                  }
               } 
               else if (self.pteam == pteam2)
               {
                  if (argv(2) == "13" || argv(2) == "12" || argv(2) == "11")
                  {
                     sprint(self,2.000,"You cannot use another teams colour as your topcolor.\n");
                     stuffcmd (self,"topcolor ");
                     st = ftos(self.pteam.colormap);
                     stuffcmd (self,st);
                     stuffcmd (self,"\n");
                     return;
                  }
               }
               else if (self.pteam == pteam3)
               {
                  if (argv(2) == "4" || argv(2) == "13" || argv(2) == "11")
                  {
                     sprint(self,2.000,"You cannot use another teams colour as your topcolor.\n");
                     stuffcmd (self,"topcolor ");
                     st = ftos(self.pteam.colormap);
                     stuffcmd (self,st);
                     stuffcmd (self,"\n");
                     return;
                  }
               } 
               else if (self.pteam == pteam4)
               {
                  if (argv(2) == "4" || argv(2) == "13" || argv(2) == "12")
                  {
                     sprint(self,2.000,"You cannot use another teams colour as your topcolor.\n");
                     stuffcmd (self,"topcolor ");
                     st = ftos(self.pteam.colormap);
                     stuffcmd (self,st);
                     stuffcmd (self,"\n");
                     return;
                  }
               }

            }

         }


         if (modetype & 4) {

            if ( ((self.pteam.team) && (teamplay) && (self.playerclass) )) {

               st = infokey (self,"topcolor");
               tc = stof (st);

               if (self.ammo_detpack) {

                  if ( tc ) {
                     stuffcmd (self,"topcolor 0\n");
                  }

               } else {

                  if (self.pteam == pteam2) {

                     if ( (self.playerclass == 8.000) && (self.undercover_team != 0.000) ) return;

                     if (tc != (self.pteam.colormap) ) {


                        stuffcmd (self,"topcolor ");
                        st = ftos(self.pteam.colormap);
                        stuffcmd (self,st);
                        stuffcmd (self,"\n");

                     }
                  }
               }
	      }
         }

         return;
      }*/

      else if (argv(1) == "rate")
      {
	   CheckConnectRate();
         return;
      }
      else if (argv(1) == "name")
      {
         if (argv(2) == string_null) 
         stuffcmd (self,"disconnect\n");

         if (argv(2) == "mercisgay") {
            stuffcmd (self,"name I am a retarded poof.\n");
            stuffcmd (self,"\n");
         }
         return;
      }


      return;
};

float(string text, float say_team) ChatMessage =
{

   local float arg_num;

	tokanize(text);

	arg_num = argc(); // tmp has been tokanized in ChatMessage function

	if (arg_num == 0)
		return 0;


      if (argv(0) == "test")
      {
		bprint(2.00,"whazzup\n");
            return 1;
      }
      return 0;
};

void (float sec, float minute, float hour, float day, float mon, float year, string date) timeofday = {

   local entity t;

   t = find(world, classname, "prematch");

   if (t != world) {

      t.no_grenades_1 = sec;
      t.no_grenades_2 = minute;
      t.tp_grenades_1 = hour;
      t.tp_grenades_2 = day; 
      t.armorclass = mon;
      t.tf_items = year;
      return;
   }

   dprint(date);
   dprint("\n");

};
