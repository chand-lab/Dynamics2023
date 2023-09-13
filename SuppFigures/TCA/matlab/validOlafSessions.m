function [Sessions, remoteDir, remoteScratch] = validOlafSessions(loc)
%
% Returns a list of valid sessions for ePhys
%
% CC - 31 March 2013
% CC - 09 February 2014, included a getLFP flag to ensure that its not out
% of whack when reading the data.
%
% All this is behavior
% ---
Sessions(1).baseDir = 'November2014';
Sessions(1).name = '04November2014';
Sessions(1).version = 'V016';
Sessions(1).TaskName = 'COLGRID';

% ---
Sessions(2).baseDir = 'November2014';
Sessions(2).name = '05November2014';
Sessions(2).version = 'V016';
Sessions(2).TaskName = 'COLGRID';

% ---
Sessions(3).baseDir = 'November2014';
Sessions(3).name = '10November2014';
Sessions(3).version = 'V016';
Sessions(3).TaskName = 'COLGRID';
% Shows lovely CoM.

% ---
Sessions(4).baseDir = 'December2014';
Sessions(4).name = '04December2014';
Sessions(4).version = 'V016';
Sessions(4).TaskName = 'COLGRID';
% Shows lovely CoM.

% ---
Sessions(5).baseDir = 'December2014';
Sessions(5).name = '03December2014';
Sessions(5).version = 'V016';
Sessions(5).TaskName = 'COLGRID';
% Shows lovely CoM.


Sessions(6).baseDir = 'December2014';
Sessions(6).name = '15December2014';
Sessions(6).version = 'V016';
Sessions(6).TaskName = 'COLGRID';
Sessions(6).saveTags = {[3:5],[8:12],[14:15]};
Sessions(6).UnitLabels(1).V = [1 2 ];
Sessions(6).Channels(1).V = [1 1];
Sessions(6).UnitLabels(2).V = [1 2 ];
Sessions(6).Channels(2).V = [1 1];
Sessions(6).UnitLabels(3).V = [1  ];
Sessions(6).Channels(3).V = [1 ];
Sessions(6).unitQuality = 'Ok';

% Shows lovely CoM.

Sessions(7).baseDir = 'December2014';
Sessions(7).name = '11December2014';
Sessions(7).version = 'V016';
Sessions(7).TaskName = 'COLGRID';
Sessions(7).saveTags = {[11 12 14]};
Sessions(7).UnitLabels(1).V = [1 2 ];
Sessions(7).Channels(1).V = [1 1];
Sessions(7).unitQuality = 'Ok';

% Shows lovely CoM.


Sessions(8).baseDir = 'December2014';
Sessions(8).name = '10December2014';
Sessions(8).version = 'V016';
Sessions(8).TaskName = 'COLGRID';
Sessions(8).saveTags = {[10]};
Sessions(8).UnitLabels(1).V = [1 2 ];
Sessions(8).Channels(1).V = [1 1];
Sessions(8).unitQuality = 'Ok';

% Shows lovely CoM.

Sessions(9).baseDir = 'December2014';
Sessions(9).name = '12December2014';
Sessions(9).version = 'V016';
Sessions(9).TaskName = 'COLGRID';
Sessions(9).saveTags = {[8]};
Sessions(9).UnitLabels(1).V = [1 2 3];
Sessions(9).Channels(1).V = [1 1 1];
Sessions(9).unitQuality = 'Ok';


Sessions(10).baseDir = 'December2014';
Sessions(10).name = '17December2014';
Sessions(10).version = 'V016';
Sessions(10).TaskName = 'COLGRID';
Sessions(10).saveTags = {[3 4]};
Sessions(10).UnitLabels(1).V = [1];
Sessions(10).Channels(1).V = [1];
Sessions(10).unitQuality = 'Ok';



Sessions(11).baseDir = 'December2014';
Sessions(11).name = '18December2014';
Sessions(11).version = 'V016';
Sessions(11).TaskName = 'COLGRID';
Sessions(11).saveTags = {[11:14],[16:21]};
Sessions(11).UnitLabels(1).V = [1 2];
Sessions(11).Channels(1).V = [1 1];
Sessions(11).UnitLabels(2).V = [1 2];
Sessions(11).Channels(2).V = [1 1];
Sessions(11).unitQuality = 'Ok';

Sessions(12).baseDir = 'December2014';
Sessions(12).name = '19December2014';
Sessions(12).version = 'V016';
Sessions(12).TaskName = 'COLGRID';
Sessions(12).saveTags = {[2],[5:9]};
Sessions(12).UnitLabels(1).V = [1];
Sessions(12).Channels(1).V = [1];
Sessions(12).UnitLabels(2).V = [2];
Sessions(12).Channels(2).V = [1];
Sessions(12).unitQuality = 'Ok';


Sessions(13).baseDir = 'December2014';
Sessions(13).name = '22December2014';
Sessions(13).version = 'V016';
Sessions(13).TaskName = 'COLGRID';
Sessions(13).saveTags = {[10 11]};
Sessions(13).UnitLabels(1).V = [1 2 1 1 1 2 3 1 2 1 1 2 1];
Sessions(13).Channels(1).V =   [4 5 5 6 7 7 8 8 8 9 12 13 14 ];
Sessions(13).ChannelsRemapped(1).V =   [4 5 5 6 7 7 8 8 8 9 12 13 14 ];
Sessions(13).unitQuality = 'Ok';

Sessions(14).baseDir = 'December2014';
Sessions(14).name = '23December2014';
Sessions(14).version = 'V016';
Sessions(14).TaskName = 'COLGRID';
Sessions(14).saveTags = {[9],[18 19 22]};
Sessions(14).UnitLabels(1).V = [2];
Sessions(14).Channels(1).V = [1];
Sessions(14).UnitLabels(2).V = [1];
Sessions(14).Channels(2).V = [1];
Sessions(14).unitQuality = 'Ok';

% Block comment on 24th December 2014.
% SaveTag 8 : 2.9 mm, nice solid visual unit. Reasonably isolated.
% SaveTag 15: 3.75 mm, very little choice
Sessions(15).baseDir = 'December2014';
Sessions(15).name = '24December2014';
Sessions(15).version = 'V016';
Sessions(15).TaskName = 'COLGRID';
Sessions(15).saveTags = {[8],[15]};
Sessions(15).UnitLabels(1).V = [1];
Sessions(15).Channels(1).V = [1];
Sessions(15).UnitLabels(2).V = [1];
Sessions(15).Channels(2).V = [1];
Sessions(15).unitQuality = 'Ok';

Sessions(16).baseDir = 'December2014';
Sessions(16).name = '25December2014';
Sessions(16).version = 'V016';
Sessions(16).TaskName = 'COLGRID';
Sessions(16).saveTags = {[4 5],[9],[13:15]};
Sessions(16).UnitLabels(1).V = [1];
Sessions(16).Channels(1).V = [1];
Sessions(16).UnitLabels(2).V = [1 2];
Sessions(16).Channels(2).V = [1 1];
Sessions(16).UnitLabels(3).V = [1];
Sessions(16).Channels(3).V = [1];
Sessions(16).unitQuality = 'Ok';


Sessions(17).baseDir = 'December2014';
Sessions(17).name = '26December2014';
Sessions(17).version = 'V016';
Sessions(17).TaskName = 'COLGRID';
Sessions(17).saveTags = {[5 6], [8 9], [12]};
Sessions(17).UnitLabels(1).V = [1];
Sessions(17).Channels(1).V = [1];
Sessions(17).UnitLabels(2).V = [1 2];
Sessions(17).Channels(2).V = [1 1];
Sessions(17).UnitLabels(3).V = [1];
Sessions(17).Channels(3).V = [1];
Sessions(17).unitQuality = 'Ok';

Sessions(18).baseDir = 'December2014';
Sessions(18).name = '29December2014';
Sessions(18).version = 'V016';
Sessions(18).TaskName = 'COLGRID';
Sessions(18).saveTags = {[6 7 9 11],[13 14 17]};
Sessions(18).UnitLabels(1).V = [1];
Sessions(18).Channels(1).V = [1];
Sessions(18).UnitLabels(2).V = [1];
Sessions(18).Channels(2).V = [1];
Sessions(18).unitQuality = 'Ok';

Sessions(19).baseDir = 'December2014';
Sessions(19).name = '30December2014';
Sessions(19).version = 'V016';
Sessions(19).TaskName = 'COLGRID';
Sessions(19).saveTags = {[7:10]};
Sessions(19).UnitLabels(1).V = [1];
Sessions(19).Channels(1).V = [1];
Sessions(19).unitQuality = 'Ok';

% 31 December 2014 ... not a good sessions
% 1st Jan 2015 ... no recording
% 02 Jan 2015 ... New burrhole

% 03 January 2015

Sessions(20).baseDir = 'January2015';
Sessions(20).name = '03January2015';
Sessions(20).version = 'V016';
Sessions(20).TaskName = 'COLGRID';
Sessions(20).saveTags = {[5 6]};
Sessions(20).UnitLabels(1).V = [1];
Sessions(20).Channels(1).V = [1];
Sessions(20).unitQuality = 'Ok';


Sessions(21).baseDir = 'January2015';
Sessions(21).name = '04January2015';
Sessions(21).version = 'V016';
Sessions(21).TaskName = 'COLGRID';
Sessions(21).saveTags = {[10 11 12 13 15]};
Sessions(21).UnitLabels(1).V = [1];
Sessions(21).Channels(1).V = [1];
Sessions(21).unitQuality = 'Ok';


Sessions(22).baseDir = 'January2015';
Sessions(22).name = '06January2015';
Sessions(22).version = 'V016';
Sessions(22).TaskName = 'COLGRID';
Sessions(22).saveTags = {[5 6 7]};
Sessions(22).UnitLabels(1).V = [1];
Sessions(22).Channels(1).V = [1];
Sessions(22).unitQuality = 'Ok';


Sessions(23).baseDir = 'January2015';
Sessions(23).name = '07January2015';
Sessions(23).version = 'V016';
Sessions(23).TaskName = 'COLGRID';
Sessions(23).saveTags = {[5:10],[7:10]};
Sessions(23).UnitLabels(1).V = [1 2];
Sessions(23).Channels(1).V = [1 1];
Sessions(23).UnitLabels(2).V = [1];
Sessions(23).Channels(2).V = [3];
Sessions(23).unitQuality = 'Ok';


% V - probe sessions
% Sessions(24).baseDir = 'January2015';
% Sessions(24).name = '09January2015';
% Sessions(24).version = 'V016';
% Sessions(24).TaskName = 'COLGRID';
% Sessions(24).saveTags = {[5:10],[7:10]};
% Sessions(24).UnitLabels(1).V = [1 2];
% Sessions(24).Channels(1).V = [1 1];
% Sessions(24).UnitLabels(2).V = [1];
% Sessions(24).Channels(2).V = [3];
% Sessions(24).unitQuality = 'Ok';


% New design V-probe remember this gets flipped around.
% Posterior Burrhole, more PMd like.

Sessions(24).baseDir = 'January2015';
Sessions(24).name = '16January2015';
Sessions(24).version = 'V016';
Sessions(24).TaskName = 'COLGRID';
Sessions(24).saveTags = {[10:15],[12:15]};
Sessions(24).UnitLabels(1).V = [1 1  1  1 2 1 2  1  1 1];
Sessions(24).Channels(1).V =   [7 9 11 13 15 4 4 6  8 14];
Sessions(24).UnitLabels(2).V = [1 1 ];
Sessions(24).Channels(2).V = [11 6];
Sessions(24).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(24).Channels(1).V);
Sessions(24).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(24).Channels(2).V);
Sessions(24).unitQuality = 'Ok';


Sessions(25).baseDir = 'January2015';
Sessions(25).name = '20January2015';
Sessions(25).version = 'V016';
Sessions(25).TaskName = 'COLGRID';
Sessions(25).saveTags = {[4:7],[9:14]};
Sessions(25).UnitLabels(1).V = [ 1  2  1  2  1 1 1 1 1];
Sessions(25).Channels(1).V =   [11 11 13 13 15 2 6 10 16];
Sessions(25).UnitLabels(2).V = [ 2  2  1 1 1  3  1];
Sessions(25).Channels(2).V =   [11 13  2 4 10 14 16];
Sessions(25).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(25).Channels(1).V);
Sessions(25).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(25).Channels(2).V);
Sessions(25).unitQuality = 'Ok';


Sessions(26).baseDir = 'January2015';
Sessions(26).name = '22January2015';
Sessions(26).version = 'V016';
Sessions(26).TaskName = 'COLGRID';
Sessions(26).saveTags = {[3:6]};
Sessions(26).UnitLabels(1).V = [1 1 2 3 1 2 -1 -1 -1];
Sessions(26).Channels(1).V =   [7 2 2 2 4 4 6 14 16];
Sessions(26).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(26).Channels(1).V);
Sessions(26).unitQuality = 'Ok';

Sessions(27).baseDir = 'January2015';
Sessions(27).name = '23January2015';
Sessions(27).version = 'V016';
Sessions(27).TaskName = 'COLGRID';
Sessions(27).saveTags = {[12:13]};
Sessions(27).UnitLabels(1).V = [ 1 ];
Sessions(27).Channels(1).V =   [13 ];
Sessions(27).unitQuality = 'Ok';

Sessions(28).baseDir = 'January2015';
Sessions(28).name = '24January2015';
Sessions(28).version = 'V016';
Sessions(28).TaskName = 'COLGRID';
Sessions(28).saveTags = {[6:8]};
Sessions(28).UnitLabels(1).V = [1 1 1 2];
Sessions(28).Channels(1).V =   [9 2 8 8 ];
Sessions(28).unitQuality = 'Ok';


%
Sessions(29).baseDir = 'January2015';
Sessions(29).name = '26January2015';
Sessions(29).version = 'V016';
Sessions(29).TaskName = 'COLGRID';
Sessions(29).saveTags = {[3:6],[3:4],[4:6]};
Sessions(29).UnitLabels(1).V = [1 1 ];
Sessions(29).Channels(1).V =   [3 9  ];
Sessions(29).UnitLabels(2).V = [1 2 2];
Sessions(29).Channels(2).V =   [13 13 8  ];
Sessions(29).UnitLabels(3).V = [3 1];
Sessions(29).Channels(3).V =   [2 6];
Sessions(29).unitQuality = 'Ok';

Sessions(30).baseDir = 'January2015';
Sessions(30).name = '27January2015';
Sessions(30).version = 'V016';
Sessions(30).TaskName = 'COLGRID';
Sessions(30).saveTags = {[2:6]};
Sessions(30).UnitLabels(1).V = [ 1  2  3 1 2 1];
Sessions(30).Channels(1).V =   [13 15 15 8 4 10];
Sessions(30).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(30).Channels(1).V);
Sessions(30).unitQuality = 'Ok';

Sessions(31).baseDir = 'January2015';
Sessions(31).name = '28January2015';
Sessions(31).version = 'V016';
Sessions(31).TaskName = 'COLGRID';
Sessions(31).saveTags = {[1:7],[1:6],[9:10]};
Sessions(31).UnitLabels(1).V = [1 1 1 2];
Sessions(31).Channels(1).V =   [5 7 9 9];
Sessions(31).UnitLabels(2).V = [1];
Sessions(31).Channels(2).V =   [8];
Sessions(31).UnitLabels(3).V = [1];
Sessions(31).Channels(3).V =   [9];
Sessions(31).unitQuality = 'Ok';

Sessions(32).baseDir = 'January2015';
Sessions(32).name = '29January2015';
Sessions(32).version = 'V016';
Sessions(32).TaskName = 'COLGRID';
Sessions(32).saveTags = {[5:13],[10:13]};
Sessions(32).UnitLabels(1).V = [-1  1];
Sessions(32).Channels(1).V =   [11 13];
Sessions(32).UnitLabels(2).V = [1 1 1 ];
Sessions(32).Channels(2).V =   [6 10 15];
Sessions(32).unitQuality = 'Ok';

Sessions(33).baseDir = 'January2015';
Sessions(33).name = '30January2015';
Sessions(33).version = 'V016';
Sessions(33).TaskName = 'COLGRID';
Sessions(33).saveTags = {[1:3]};
Sessions(33).UnitLabels(1).V = [1  1  2  3 1 1  1];
Sessions(33).Channels(1).V =   [5 15 15 15 6 8 14];
% Sessions(33).UnitLabels(2).V = [1];
% Sessions(33).Channels(2).V =   [6];
Sessions(33).unitQuality = 'Ok';

Sessions(34).baseDir = 'January2015';
Sessions(34).name = '31January2015';
Sessions(34).version = 'V016';
Sessions(34).TaskName = 'COLGRID';
Sessions(34).saveTags = {[8:15]};
Sessions(34).UnitLabels(1).V = [1 ];
Sessions(34).Channels(1).V =   [11 ];
% Sessions(33).UnitLabels(2).V = [1];
% Sessions(33).Channels(2).V =   [6];
Sessions(34).unitQuality = 'Ok';


Sessions(35).baseDir = 'February2015';
Sessions(35).name = '01February2015';
Sessions(35).version = 'V016';
Sessions(35).TaskName = 'COLGRID';
Sessions(35).saveTags = {[10:14],[10:14]};
Sessions(35).UnitLabels(1).V = [1 ];
Sessions(35).Channels(1).V =   [13 ];
Sessions(35).UnitLabels(2).V = [2 ];
Sessions(35).Channels(2).V =   [13 ];
% Sessions(33).UnitLabels(2).V = [1];
% Sessions(33).Channels(2).V =   [6];
Sessions(35).unitQuality = 'Ok';

Sessions(36).baseDir = 'February2015';
Sessions(36).name = '03February2015';
Sessions(36).version = 'V016';
Sessions(36).TaskName = 'COLGRID';
Sessions(36).saveTags = {[1:6]};
Sessions(36).UnitLabels(1).V = [1 1 2 1 2 3 1 1  1  1 1];
Sessions(36).Channels(1).V =   [3 5 5 7 7 7 9 13 15 2 4];
Sessions(36).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(36).Channels(1).V);
Sessions(36).unitQuality = 'Ok';


Sessions(37).baseDir = 'February2015';
Sessions(37).name = '04February2015';
Sessions(37).version = 'V016';
Sessions(37).TaskName = 'COLGRID';
Sessions(37).saveTags = {[1:7],[12:14]};
Sessions(37).UnitLabels(1).V = [1 1] ;
Sessions(37).Channels(1).V =   [5 16];
Sessions(37).UnitLabels(2).V = [1 1 1  1  2  2] ;
Sessions(37).Channels(2).V =   [3 9 11 13 15 2];
Sessions(37).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(37).Channels(1).V);
Sessions(37).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(37).Channels(2).V);
Sessions(37).unitQuality = 'Ok';

Sessions(38).baseDir = 'February2015';
Sessions(38).name = '05February2015';
Sessions(38).version = 'V016';
Sessions(38).TaskName = 'COLGRID';
Sessions(38).saveTags = {[7]};
Sessions(38).UnitLabels(1).V = [ 1 2  1  1  2  1  2  1 1 1 2 3] ;
Sessions(38).Channels(1).V =   [ 9 11 11 13 13 15 15 2 4 6 6 6] ;
Sessions(38).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(38).Channels(1).V);
Sessions(38).unitQuality = 'Ok';

Sessions(39).baseDir = 'February2015';
Sessions(39).name = '06February2015';
Sessions(39).version = 'V016';
Sessions(39).TaskName = 'COLGRID';
Sessions(39).saveTags = {[5:6]};
Sessions(39).UnitLabels(1).V = [1 1 2 -1] ;
Sessions(39).Channels(1).V =   [2 13 13 11] ;
Sessions(39).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(39).Channels(1).V);
Sessions(39).unitQuality = 'Ok';

sessionId = 39;
% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '01April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';


% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '02April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';
%
%
% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '02April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';
%
%
% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '03April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';
%
% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '06April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';
%
% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '07April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';
%
% sessionId = sessionId+1;
% Sessions(sessionId).baseDir = 'April2015';
% Sessions(sessionId).name = '08April2015';
% Sessions(sessionId).version = 'V016';
% Sessions(sessionId).TaskName = 'COLGRID';
% Sessions(sessionId).saveTags = {};
% Sessions(sessionId).UnitLabels(1).V = [] ;
% Sessions(sessionId).Channels(1).V =   [] ;
% Sessions(sessionId).unitQuality = 'Ok';

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '15April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {5:7};
Sessions(sessionId).UnitLabels(1).V = [-1 1 2 2 1 1  1  0  1] ;
Sessions(sessionId).Channels(1).V =   [7  9 9 2 4 6 13 13 15] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).unitQuality = 'Ok';

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '16April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[6:13],[13:15]};
Sessions(sessionId).UnitLabels(1).V = [1 2 3   -1 -1] ;
Sessions(sessionId).Channels(1).V =   [13 13 13 2  4] ;
Sessions(sessionId).UnitLabels(2).V = [1 1] ;
Sessions(sessionId).Channels(2).V =   [4 9] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);
Sessions(sessionId).unitQuality = 'Ok';

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '14April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[3:6],[9:12]};
Sessions(sessionId).UnitLabels(1).V = [1] ;
Sessions(sessionId).Channels(1).V =   [1] ;
Sessions(sessionId).UnitLabels(2).V = [1] ;
Sessions(sessionId).Channels(2).V =   [1] ;
Sessions(sessionId).unitQuality = 'Ok';


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '17April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[4:10]};
Sessions(sessionId).UnitLabels(1).V = [1   2  1  2 1 1 2 1 2  1] ;
Sessions(sessionId).Channels(1).V =   [11 13 15 15 6 4 4 8 2 10] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).unitQuality = 'Ok';

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '18April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[3:10]};
Sessions(sessionId).UnitLabels(1).V = [1 -1 -1  1  2 2 3 1 2 1 2];
Sessions(sessionId).Channels(1).V =   [9 11 13 15 15 2 2 6 6 8 8];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).unitQuality = 'Ok';

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '19April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[1:6]};
Sessions(sessionId).UnitLabels(1).V = [1 3 2  1 1 -1 -1 -1 -1 -1 1];
Sessions(sessionId).Channels(1).V =   [7 9 9 10 6 11 13 15  2  4 12 ];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '21April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[3:8]};
Sessions(sessionId).UnitLabels(1).V = [0   1  1 -1 1 -1];
Sessions(sessionId).Channels(1).V =   [15 15 13  2 4  6];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '22April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[4:7],[9:13],[11:13]};
Sessions(sessionId).UnitLabels(1).V = [-1 1 1 2  1  1 1 -1 -1];
Sessions(sessionId).Channels(1).V =   [ 5 7 9 9 11 13 4 14 16];
Sessions(sessionId).UnitLabels(2).V = [ 1 -1 -1 ];
Sessions(sessionId).Channels(2).V =   [ 7  9 13  ];
Sessions(sessionId).UnitLabels(3).V = [ 1  ];
Sessions(sessionId).Channels(3).V =   [ 4   ];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);
Sessions(sessionId).ChannelsRemapped(3).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(3).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '23April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {9:14};
Sessions(sessionId).UnitLabels(1).V = [-1 -1  2  1  3  5  2  1 3 2 -1 -1 2  1] ;
Sessions(sessionId).Channels(1).V =   [ 9 11 13  2 15 15 15 15 2 2  4  6 12 16];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '24April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {1:9};
Sessions(sessionId).UnitLabels(1).V = [1 2  1  2  3  1  2  3  1  2 1 1 1  1]  ;
Sessions(sessionId).Channels(1).V =   [9 9 11 11 11 13 13 13 15 15 2 6 8 12];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'April2015';
Sessions(sessionId).name = '30April2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {4:7};
Sessions(sessionId).UnitLabels(1).V = [0 1  1 3  1 2  1 1 2 1  2]  ;
Sessions(sessionId).Channels(1).V =   [9 9 11 11 13 15 2 4 4 8 12];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '01May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[2:9]};
Sessions(sessionId).UnitLabels(1).V = [-1 1  2  1  2  1 3  1 2 1 -1 1 1];
Sessions(sessionId).Channels(1).V =   [9 11 11 13 13 15 15 2 2 6 8 12 14];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '02May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[4:7]};
Sessions(sessionId).UnitLabels(1).V = [-1 1 2 1 -1 -1  2  3 1 1 1 2  1  1] ;
Sessions(sessionId).Channels(1).V =   [ 5 7 7 9 11 13 15 15 2 4 6 6 10 12] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


% Try for classifiers.
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '03May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[7:11]};
Sessions(sessionId).UnitLabels(1).V = [ 2  1 -1 0 1 1 2 3 1 2 3 -1  1 1  0 1 2 1] ;
Sessions(sessionId).Channels(1).V =   [14 12 10 8 8 6 4 4 2 2 2 15 13 11 11  9 9 5] ;
Sessions(sessionId).unitsToInclude =    [2  -1 0 1 1 2 3 1 2 3 -1  1 1  0 1 2 1]' ;
Sessions(sessionId).channelsToInclude = [14 10 8 8 6 4 4 2 2 2 15 13 11 11  9 9 5] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);



sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '04May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[1:6],[9:12]};
Sessions(sessionId).UnitLabels(1).V = [ 1 1 1 2 1  ] ;
Sessions(sessionId).Channels(1).V =   [ 7 6 8 9 10 ] ;
Sessions(sessionId).UnitLabels(2).V = [-1 1 1 3  2] ;
Sessions(sessionId).Channels(2).V =   [ 5 7 8 11 13] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);



sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '06May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[1:12]};
Sessions(sessionId).UnitLabels(1).V = [-1 1 1  1  1 2 2 1 1 2 1  1 1] ;
Sessions(sessionId).Channels(1).V =    [3 5 11 15 2 2 4 4 6 6 8 14 16] ;
Sessions(sessionId).unitsToInclude = [-1 1 1  1  1 2 2 1 1 2 1  1 1]' ;
Sessions(sessionId).channelsToInclude =    [3 5 11 15 2 2 4 4 6 6 8 14 16]' ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);



% see Evernote. This was a good session. Palpation suggested upper arm /
% bicep like tuning.
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '07May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[11:16]};
Sessions(sessionId).UnitLabels(1).V = [1 1 2  1 1 1  1]  ;
Sessions(sessionId).Channels(1).V =   [3 5 5 11 4 8 16] ;
Sessions(sessionId).unitsToInclude = [1 1 2  1 1 1  1]' ;
Sessions(sessionId).channelsToInclude =  [3 5 5 11 4 8 16]'  ;
% Need to go back here! Wherever the fuck this was. I think this is the
% posterior burrhole. Need to go back and try that repeatedly.
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '08May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[9:11],[12:16]};
Sessions(sessionId).UnitLabels(1).V = [1 2 3 -1  1  1]  ;
Sessions(sessionId).Channels(1).V =   [2 2 2  7 13 16] ;
Sessions(sessionId).UnitLabels(2).V = [1 2 3 1  1  1]  ;
Sessions(sessionId).Channels(2).V =   [2 2 2 7 13 16] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '09May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[4:12],[16:18], [16:24]};
Sessions(sessionId).UnitLabels(1).V = [1 -1]  ;
Sessions(sessionId).Channels(1).V =   [7 11] ;
Sessions(sessionId).UnitLabels(2).V = [ 1 ]  ;
Sessions(sessionId).Channels(2).V =   [16 ] ;
Sessions(sessionId).UnitLabels(3).V = [1 -1 -1 -1 -1]  ;
Sessions(sessionId).Channels(3).V =   [7 13 15  8  2] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);
Sessions(sessionId).ChannelsRemapped(3).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(3).V);


% @3.440 mm. Palpation seemed weird and interesting. Not able to precisely
% localize. Am going more posterior to get more choice related signals.
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '10May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[7:12]};
Sessions(sessionId).UnitLabels(1).V = [1 1 2  1  3 1  1  3]  ;
Sessions(sessionId).Channels(1).V =   [2 4 4 11 15 8 10 10] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


% Better choice related signals
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '12May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[7:12],[14]};
Sessions(sessionId).UnitLabels(1).V = [-1]  ;
Sessions(sessionId).Channels(1).V =   [15 ] ;
Sessions(sessionId).UnitLabels(2).V = [ 1 -1 1]  ;
Sessions(sessionId).Channels(2).V =   [14 13 2] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);


%@3.649 mm. Not very left right tuned.
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '13May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[8:11]};
Sessions(sessionId).UnitLabels(1).V = [1 1 1 1 1 -1]  ;
Sessions(sessionId).Channels(1).V =   [3 5 9 2 14 16 ] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


%@3.6 mm nice premovement activity less LR tuning than I would like
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '14May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[5:8]};
Sessions(sessionId).UnitLabels(1).V = [1 2 3 4 1 1 2 1 2  1  1]  ;
Sessions(sessionId).Channels(1).V =   [9 9 9 9 2 8 8 7 7 13 15];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '15May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[1:8]};
Sessions(sessionId).UnitLabels(1).V = [1 1 1  -1 1 1]  ;
Sessions(sessionId).Channels(1).V =   [7 9 4 13 14 16];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '16May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[9:13],[13]};
Sessions(sessionId).UnitLabels(1).V = [1 1]  ;
Sessions(sessionId).Channels(1).V =   [4 15];
Sessions(sessionId).UnitLabels(2).V = [1]  ;
Sessions(sessionId).Channels(2).V =   [10];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '17May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[4:7 14:18],[4:7],[4:7 17:18],[17:18] };
Sessions(sessionId).UnitLabels(1).V = [1]  ;
Sessions(sessionId).Channels(1).V =   [4];
Sessions(sessionId).UnitLabels(2).V = [1]  ;
Sessions(sessionId).Channels(2).V =   [9];
Sessions(sessionId).UnitLabels(3).V = [1  1]  ;
Sessions(sessionId).Channels(3).V =   [12 14];
Sessions(sessionId).UnitLabels(4).V = [1  2 1]  ;
Sessions(sessionId).Channels(4).V =   [11 9 7];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);
Sessions(sessionId).ChannelsRemapped(3).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(3).V);
Sessions(sessionId).ChannelsRemapped(4).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(4).V);


% @ 3.754 mm - need longer period of stabilization.
sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '19May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[3:10] };
Sessions(sessionId).UnitLabels(1).V = [2 1 1 2 1]  ;
Sessions(sessionId).Channels(1).V =   [7 6 4 4 12];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '20May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[1:6] };
Sessions(sessionId).UnitLabels(1).V = [2  2   1  1  3  1]  ;
Sessions(sessionId).Channels(1).V =   [7 11 13 15 15 16];
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '21May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[11:12] };
Sessions(sessionId).UnitLabels(1).V = [1 2 2 2 1  1 ]  ;
Sessions(sessionId).Channels(1).V =   [5 5 7 9 4 13] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '22May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[1:6],[13:15]};
Sessions(sessionId).UnitLabels(1).V = [-1 1  1   2 ]  ;
Sessions(sessionId).Channels(1).V =   [ 5 11 10 12 ] ;
Sessions(sessionId).UnitLabels(2).V = [-1 2  1  2  3  1 1  1 ]  ;
Sessions(sessionId).Channels(2).V =   [7  9  9 11  11 4 8 10]  ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);

sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '25May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[4:7],[11 13:16]};
Sessions(sessionId).UnitLabels(1).V = [1 -1  1  1  2]  ;
Sessions(sessionId).Channels(1).V =   [9 13 15 10 10] ;
Sessions(sessionId).UnitLabels(2).V = [ 1  1]  ;
Sessions(sessionId).Channels(2).V =   [11  8]  ;
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);
Sessions(sessionId).ChannelsRemapped(2).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(2).V);


sessionId = sessionId+1;
Sessions(sessionId).baseDir = 'May2015';
Sessions(sessionId).name = '26May2015';
Sessions(sessionId).version = 'V016';
Sessions(sessionId).TaskName = 'COLGRID';
Sessions(sessionId).saveTags = {[10:15 17]};
Sessions(sessionId).UnitLabels(1).V = [ 1  1]  ;
Sessions(sessionId).Channels(1).V =   [15 11] ;
Sessions(sessionId).ChannelsRemapped(1).V =   remapContactsOnUprobe(Sessions(sessionId).Channels(1).V);

[~, sysname] = system('hostname');

for nS = 1:length(Sessions)
    Sessions(nS).getLFP = false;
    Sessions(nS).monkey = 'Olaf';
    Sessions(nS).TaskName = 'COLGRID';
end


if ~strcmp(sysname,'rig5dataLogger')
    remoteDir = '/net/data/OlafD/Data/dataLoggerFiles/';
    remoteScratch = '/net/derived/chand/';
    if ~exist(remoteScratch)
        mkdir(remoteScratch)
    end
else
    remoteDir = '/data/ChandData/Tiberius/';
    for nS = 1:length(Sessions)
        Sessions(nS).baseDir = 'Tiberius';
        Sessions(nS).getLFP = false;
    end
end