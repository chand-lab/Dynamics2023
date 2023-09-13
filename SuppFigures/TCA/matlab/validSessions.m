function [Sessions, remoteDir, remoteScratch] = validSessions(loc)
%
% Returns a list of valid sessions for ePhys
%
% CC - 31 March 2013
% CC - 09 February 2014, included a getLFP flag to ensure that its not out
% of whack when reading the data.
%
Sessions(1).baseDir = 'January2013';
Sessions(1).name = '24January2013';
Sessions(1).saveTags = [{2} {4} {6} {8}];
Sessions(1).UnitLabels(1).V = [1];
Sessions(1).UnitLabels(2).V = [1 2];
Sessions(1).UnitLabels(3).V = [1 ];
Sessions(1).UnitLabels(4).V = [1 2];
Sessions(1).Channels(1).V = [1];
Sessions(1).Channels(2).V = [1 1];
Sessions(1).Channels(3).V = [1 ];
Sessions(1).Channels(4).V = [1 1];
Sessions(1).version = 'V003';


Sessions(2).baseDir = 'January2013';
Sessions(2).name = '25January2013';
Sessions(2).saveTags = [{2} {4} {5} {6} {9} ];
Sessions(2).version = 'V003';
Sessions(2).UnitLabels(1).V = [1 2];
Sessions(2).UnitLabels(2).V = [1 2];
Sessions(2).UnitLabels(3).V = [1 2];
Sessions(2).UnitLabels(4).V = [1];
Sessions(2).UnitLabels(5).V = [1];
Sessions(2).Channels(1).V = [1 1];
Sessions(2).Channels(2).V = [1 1];
Sessions(2).Channels(3).V = [1 1];
Sessions(2).Channels(4).V = [1];
Sessions(2).Channels(5).V = [1];


Sessions(3).baseDir = 'January2013';
Sessions(3).name = '28January2013';
Sessions(3).saveTags = [{3} {5} {7}];
Sessions(3).version = 'V003';
Sessions(3).UnitLabels(1).V = [1 2];
Sessions(3).UnitLabels(2).V = [1 2];
Sessions(3).UnitLabels(3).V = [1 2];

Sessions(3).Channels(1).V = [1 1];
Sessions(3).Channels(2).V = [1 1];
Sessions(3).Channels(3).V = [1 1];



Sessions(4).baseDir = 'January2013';
Sessions(4).name = '29January2013';
Sessions(4).saveTags = [{6} {8}];
Sessions(4).version = 'V003';
Sessions(4).UnitLabels(1).V = [-1];
Sessions(4).UnitLabels(2).V = [0 1 2];
Sessions(4).Channels(1).V = [1];
Sessions(4).Channels(2).V = [1 1 1];



Sessions(5).baseDir = 'April2013';
Sessions(5).name = '02April2013';
Sessions(5).saveTags = [{2} {4} {6}];
Sessions(5).UnitLabels(1).V = [1];
Sessions(5).UnitLabels(2).V = [1];
Sessions(5).UnitLabels(3).V = [1];

Sessions(5).Channels(1).V = [1];
Sessions(5).Channels(2).V = [1];
Sessions(5).Channels(3).V = [1];
Sessions(5).version = 'V012';


Sessions(6).baseDir = 'April2013';
Sessions(6).name = '03April2013';
Sessions(6).saveTags = [{2} {4} {7} {10}];
Sessions(6).version = 'V012';
Sessions(6).UnitLabels(1).V = [1 2];
Sessions(6).UnitLabels(2).V = [1];
Sessions(6).UnitLabels(3).V = [1];
Sessions(6).UnitLabels(4).V = [1 2];

Sessions(6).Channels(1).V = [1 1];
Sessions(6).Channels(2).V = [1];
Sessions(6).Channels(3).V = [1];
Sessions(6).Channels(4).V = [1 1];


Sessions(7).baseDir = 'April2013';
Sessions(7).name = '04April2013';
Sessions(7).saveTags = [{12}];
Sessions(7).version = 'V012';
Sessions(7).UnitLabels(1).V = 2;
Sessions(7).Channels(1).V = 1;


Sessions(8).baseDir = 'April2013';
Sessions(8).name = '10April2013';
Sessions(8).saveTags = [{3} {5} {7} {8}];
Sessions(8).version = 'V012';
Sessions(8).UnitLabels(1).V = -1;
Sessions(8).UnitLabels(2).V = -1;
Sessions(8).UnitLabels(3).V = -1;
Sessions(8).UnitLabels(4).V = -1;

Sessions(8).Channels(1).V = 1;
Sessions(8).Channels(2).V =1;
Sessions(8).Channels(3).V =1;
Sessions(8).Channels(4).V = 1;


Sessions(9).baseDir = 'April2013';
Sessions(9).name = '11April2013';
Sessions(9).saveTags = [{11} {13}];
Sessions(9).version = 'V012';
Sessions(9).UnitLabels(1).V = -1;
Sessions(9).UnitLabels(2).V = -1;
Sessions(9).Channels(1).V = 1;
Sessions(9).Channels(2).V = 1;


Sessions(10).baseDir = 'April2013';
Sessions(10).name = '12April2013';
Sessions(10).saveTags = [{5} {10}];
Sessions(10).version = 'V012';
Sessions(10).UnitLabels(1).V = -1;
Sessions(10).UnitLabels(2).V = -1;
Sessions(10).Channels(1).V = 1;
Sessions(10).Channels(2).V = 1;


Sessions(11).baseDir = 'April2013';
Sessions(11).name = '16April2013';
Sessions(11).saveTags = [{2} {6} {8}];
Sessions(11).version = 'V012';
Sessions(11).UnitLabels(1).V = [1];
Sessions(11).UnitLabels(2).V = -1;
Sessions(11).UnitLabels(3).V = -1;
Sessions(11).Channels(1).V = [1];
Sessions(11).Channels(2).V = 1;
Sessions(11).Channels(3).V = 1;



Sessions(12).baseDir = 'April2013';
Sessions(12).name = '17April2013';
Sessions(12).saveTags = [{4} {7}];
Sessions(12).version = 'V012';
Sessions(12).UnitLabels(1).V = [-1];
Sessions(12).UnitLabels(2).V = -1;
Sessions(12).Channels(1).V = [1];
Sessions(12).Channels(2).V = [1];


Sessions(13).baseDir = 'April2013';
Sessions(13).name = '18April2013';
Sessions(13).saveTags = [{4} {8} {9} {11}];
Sessions(13).version = 'V012';
Sessions(13).UnitLabels(1).V = [1];
Sessions(13).UnitLabels(2).V = -1;
Sessions(13).UnitLabels(3).V = [1];
Sessions(13).UnitLabels(4).V = 1;
Sessions(13).Channels(1).V = [1];
Sessions(13).Channels(2).V = [1];
Sessions(13).Channels(3).V = [1];
Sessions(13).Channels(4).V = [1];


Sessions(14).baseDir = 'April2013';
Sessions(14).name = '19April2013';
Sessions(14).saveTags = [{3} {5}];
Sessions(14).version = 'V012';
Sessions(14).UnitLabels(1).V = [1];
Sessions(14).UnitLabels(2).V = 1;
Sessions(14).Channels(1).V = [1];
Sessions(14).Channels(2).V = 1;



Sessions(15).baseDir = 'April2013';
Sessions(15).name = '22April2013';
Sessions(15).saveTags = [{3} {5} {8}];
Sessions(15).version = 'V012';
Sessions(15).UnitLabels(1).V = [-1];
Sessions(15).UnitLabels(2).V = -1;
Sessions(15).UnitLabels(3).V = 1;

Sessions(15).Channels(1).V = 1;
Sessions(15).Channels(2).V = 1;
Sessions(15).Channels(3).V = 1;



Sessions(16).baseDir = 'April2013';
Sessions(16).name = '23April2013';
Sessions(16).saveTags = [{3} {5} {6} {8} {9}];
Sessions(16).version = 'V012';
Sessions(16).UnitLabels(1).V = [1];
Sessions(16).UnitLabels(2).V = [1 2];
Sessions(16).UnitLabels(3).V = [1 2];
Sessions(16).UnitLabels(4).V = [1 2 3];
Sessions(16).UnitLabels(5).V = [1];

Sessions(16).Channels(1).V = [1];
Sessions(16).Channels(2).V = [1 1];
Sessions(16).Channels(3).V = [1 1];
Sessions(16).Channels(4).V = [1 1 1];
Sessions(16).Channels(5).V = [1];


Sessions(17).baseDir = 'April2013';
Sessions(17).name = '25April2013';
Sessions(17).saveTags = [{7} {9} {12}];
Sessions(17).version = 'V012';
Sessions(17).UnitLabels(1).V = [-1];
Sessions(17).UnitLabels(2).V = [1];
Sessions(17).UnitLabels(3).V = [-1];

Sessions(17).Channels(1).V = [1];
Sessions(17).Channels(2).V = [1];
Sessions(17).Channels(3).V = [1];


Sessions(18).baseDir = 'April2013';
Sessions(18).name = '26April2013';
Sessions(18).saveTags = [{2} {4} {8} {9}];
Sessions(18).version = 'V012';

Sessions(18).UnitLabels(1).V = [1];
Sessions(18).UnitLabels(2).V = [1 2];
Sessions(18).UnitLabels(3).V = [-1];
Sessions(18).UnitLabels(4).V = [1 2 3];

Sessions(18).Channels(1).V = [1];
Sessions(18).Channels(2).V = [1 1];
Sessions(18).Channels(3).V = [1];
Sessions(18).Channels(4).V = [1 1 1];


Sessions(19).baseDir = 'April2013';
Sessions(19).name = '29April2013';
Sessions(19).saveTags = [{2} {4} {7} {8}];
Sessions(19).version = 'V012';
Sessions(19).UnitLabels(1).V = [1];
Sessions(19).UnitLabels(2).V = [1 2];
Sessions(19).UnitLabels(3).V = [-1];
Sessions(19).UnitLabels(4).V = [1];

Sessions(19).Channels(1).V = [1];
Sessions(19).Channels(2).V = [1 1];
Sessions(19).Channels(3).V = [1];
Sessions(19).Channels(4).V = [1];


Sessions(20).baseDir = 'May2013';
Sessions(20).name = '20May2013';
Sessions(20).saveTags = [{5} {6} {7}];
Sessions(20).version = 'V012';
Sessions(20).UnitLabels(1).V = [1];
Sessions(20).UnitLabels(2).V = [1];
Sessions(20).UnitLabels(3).V = [1];

Sessions(20).Channels(1).V = [1];
Sessions(20).Channels(2).V = [1];
Sessions(20).Channels(3).V = [1];



Sessions(21).baseDir = 'May2013';
Sessions(21).name = '21May2013';
Sessions(21).saveTags = {[2], [3 4 5]};
Sessions(21).version = 'V012';
Sessions(21).UnitLabels(1).V = [1];
Sessions(21).UnitLabels(2).V = [1];

Sessions(21).Channels(1).V = [1];
Sessions(21).Channels(2).V = [1];


Sessions(22).baseDir = 'May2013';
Sessions(22).name = '22May2013';
Sessions(22).saveTags = [{2} {[5 6]}];
Sessions(22).version = 'V012';
Sessions(22).UnitLabels(1).V = [1];
Sessions(22).UnitLabels(2).V = [-1];

Sessions(22).Channels(1).V = [1];
Sessions(22).Channels(2).V = [1];


Sessions(23).baseDir = 'May2013';
Sessions(23).name = '23May2013';
Sessions(23).saveTags = [{5} {8}];
Sessions(23).version = 'V012';
Sessions(23).UnitLabels(1).V = [-1];
Sessions(23).UnitLabels(2).V = [1];
Sessions(23).Channels(1).V = [1];
Sessions(23).Channels(2).V = [1];


Sessions(24).baseDir = 'May2013';
Sessions(24).name = '24May2013';
Sessions(24).saveTags = {[3], [5], [7 8 9]};
Sessions(24).version = 'V012';
Sessions(24).UnitLabels(1).V = [1];
Sessions(24).UnitLabels(2).V = [1];
Sessions(24).UnitLabels(3).V = [1];
Sessions(24).Channels(1).V = [1];
Sessions(24).Channels(2).V = [1];
Sessions(24).Channels(3).V = [1];


% Multisave Tag Session
Sessions(25).baseDir = 'May2013';
Sessions(25).name = '27May2013';
Sessions(25).saveTags = {[4], [6], [7 8 9 10]};
Sessions(25).version = 'V012';
Sessions(25).UnitLabels(1).V = [1 2];
Sessions(25).UnitLabels(2).V = [1 2 3];
Sessions(25).UnitLabels(3).V = [1];
Sessions(25).Channels(1).V = [1 1];
Sessions(25).Channels(2).V = [1 1 1];
Sessions(25).Channels(3).V = [1 1];

% Multisave Tag Session
Sessions(26).baseDir = 'May2013';
Sessions(26).name = '28May2013';
Sessions(26).saveTags = {[3 4 5 6]};
Sessions(26).version = 'V012';
Sessions(26).UnitLabels(1).V = [1];
Sessions(26).Channels(1).V = [1];

Sessions(27).baseDir = 'June2013';
Sessions(27).name = '04June2013';
Sessions(27).saveTags = {[10], [12]};
Sessions(27).version = 'V012';
Sessions(27).UnitLabels(1).V = [1 2];
Sessions(27).UnitLabels(2).V = [1 2];

Sessions(27).Channels(1).V = [1 1];
Sessions(27).Channels(2).V = [1 1];


Sessions(28).baseDir = 'June2013';
Sessions(28).name = '05June2013';
Sessions(28).saveTags = {[3]};
Sessions(28).version = 'V012';
Sessions(28).UnitLabels(1).V = [1 2];
Sessions(28).Channels(1).V = [1 1];



Sessions(29).baseDir = 'June2013';
Sessions(29).name = '06June2013';
Sessions(29).saveTags = {[3 4], [5], [8]};
Sessions(29).version = 'V012';
Sessions(29).UnitLabels(1).V = [1];
Sessions(29).UnitLabels(2).V = [1];
Sessions(29).UnitLabels(3).V = [1 2];
Sessions(29).Channels(1).V = [1];
Sessions(29).Channels(2).V = [1];
Sessions(29).Channels(3).V = [1 1];


Sessions(30).baseDir = 'June2013';
Sessions(30).name = '07June2013';
Sessions(30).saveTags = {[5], [12]};
Sessions(30).version = 'V012';
Sessions(30).UnitLabels(1).V = [1];
Sessions(30).UnitLabels(2).V = [-1];
Sessions(30).Channels(1).V = [1];
Sessions(30).Channels(2).V = [1];



Sessions(31).baseDir = 'June2013';
Sessions(31).name = '11June2013';
Sessions(31).saveTags = {[8 9 10]};
Sessions(31).version = 'V012';
Sessions(31).UnitLabels(1).V = [1];
Sessions(31).Channels(1).V = [1 1];

% 12 June 2013, was omitted due to issues with the dataLogger.

Sessions(32).baseDir = 'June2013';
Sessions(32).name = '13June2013';
Sessions(32).saveTags = {[6]};
Sessions(32).saveTags = {[10]};
Sessions(32).version = 'V012';
Sessions(32).UnitLabels(1).V = [3]; % More MUA than SUA.
Sessions(32).UnitLabels(1).V = [1];

Sessions(32).Channels(1).V = [1]; % More MUA than SUA.
Sessions(32).Channels(1).V = [1];


Sessions(33).baseDir = 'June2013';
Sessions(33).name = '14June2013';
Sessions(33).saveTags = {[10 11]};
Sessions(33).version = 'V012';
Sessions(33).UnitLabels(1).V = [1]; % More MUA than SUA.
Sessions(33).Channels(1).V = [1]; % More MUA than SUA.

Sessions(34).baseDir = 'June2013';
Sessions(34).name = '17June2013';
Sessions(34).saveTags = {[3 4],[5]};
Sessions(34).version = 'V012';
Sessions(34).UnitLabels(1).V = [1];
Sessions(34).UnitLabels(2).V = [1 2];
Sessions(34).Channels(1).V = [1]; % More MUA than SUA.
Sessions(34).Channels(2).V = [1 1]; % More MUA than SUA.

Sessions(35).baseDir = 'June2013';
Sessions(35).name = '18June2013';
Sessions(35).saveTags = {[3 4],[6 7]};
Sessions(35).version = 'V012';
Sessions(35).UnitLabels(1).V = [1 2];
Sessions(35).UnitLabels(2).V = [1];
Sessions(35).Channels(1).V = [1 1];
Sessions(35).Channels(2).V = [1];



Sessions(36).baseDir = 'June2013';
Sessions(36).name = '19June2013';
Sessions(36).saveTags = {[9 10]};
Sessions(36).version = 'V012';
Sessions(36).UnitLabels(1).V = [1 2];
Sessions(36).Channels(1).V = [1 1];

Sessions(37).baseDir = 'June2013';
Sessions(37).name = '20June2013';
Sessions(37).saveTags = {[3 4 5 8],[7]};
Sessions(37).version = 'V012';
Sessions(37).UnitLabels(1).V = [1];
Sessions(37).UnitLabels(2).V = [1];
Sessions(37).Channels(1).V = [1];
Sessions(37).Channels(2).V = [1];



% Interesting day, burrhole 3, all of them were predominantly movement
% senstive. Made the mistake of using the wrong electrode box. Got shit
% initially but quickly rearranged to use a new electrode instead. Got
% shoulder or pectoral muscle activity.
Sessions(38).baseDir = 'June2013';
Sessions(38).name = '21June2013';
Sessions(38).saveTags = {[2],[4],[9 10],[13]};
Sessions(38).version = 'V012';
Sessions(38).UnitLabels(1).V = [1];
Sessions(38).UnitLabels(2).V = [1];
Sessions(38).UnitLabels(3).V = [1];
Sessions(38).UnitLabels(4).V = [1];

Sessions(38).Channels(1).V = [1];
Sessions(38).Channels(2).V = [1];
Sessions(38).Channels(3).V = [1];
Sessions(38).Channels(4).V = [1];


Sessions(39).baseDir = 'June2013';
Sessions(39).name = '26June2013';
Sessions(39).saveTags = {[3 4],[9 10],[12 13]};
Sessions(39).version = 'V012';
Sessions(39).UnitLabels(1).V = [1];
Sessions(39).UnitLabels(2).V = [1 2];
Sessions(39).UnitLabels(3).V = [1];

Sessions(39).Channels(1).V = [1];
Sessions(39).Channels(2).V = [1 1];
Sessions(39).Channels(3).V = [1];


Sessions(40).baseDir = 'June2013';
Sessions(40).name = '27June2013';
Sessions(40).saveTags = {[6],[7],[8 9 10 11 12]};
Sessions(40).version = 'V012';
Sessions(40).UnitLabels(1).V = [1];
Sessions(40).UnitLabels(2).V = [1 2];
Sessions(40).UnitLabels(3).V = [1];

Sessions(40).Channels(1).V = 1;
Sessions(40).Channels(2).V = [1 1];
Sessions(40).Channels(3).V = [1];

Sessions(41).baseDir = 'June2013';
Sessions(41).name = '28June2013';
Sessions(41).saveTags = {[2 3 ],[6 7]};
Sessions(41).version = 'V012';
Sessions(41).UnitLabels(1).V = [1];
Sessions(41).UnitLabels(2).V = [1];

Sessions(41).Channels(1).V = [1];
Sessions(41).Channels(2).V = [1];


Sessions(42).baseDir = 'July2013';
Sessions(42).name = '01July2013';
Sessions(42).saveTags = {[8 9 10]};
Sessions(42).version = 'V012';
Sessions(42).UnitLabels(1).V = [1];
Sessions(42).Channels(1).V = [1];



Sessions(43).baseDir = 'July2013';
Sessions(43).name = '02July2013';
Sessions(43).saveTags = {[7],[11 12]};
Sessions(43).version = 'V012';
Sessions(43).UnitLabels(1).V = [1];
Sessions(43).UnitLabels(2).V = [1 2];
Sessions(43).Channels(1).V = [1];
Sessions(43).Channels(2).V = [1 1];


Sessions(44).baseDir = 'July2013';
Sessions(44).name = '03July2013';
Sessions(44).saveTags = {[2],[7 11 12]};
Sessions(44).version = 'V012';
Sessions(44).UnitLabels(1).V = [1];
Sessions(44).UnitLabels(2).V = [1];
Sessions(44).Channels(1).V = [1];
Sessions(44).Channels(2).V = [1];


Sessions(45).baseDir = 'July2013';
Sessions(45).name = '04July2013';
Sessions(45).saveTags = {[7 9]};
Sessions(45).version = 'V012';
Sessions(45).UnitLabels(1).V = [1];
Sessions(45).Channels(1).V = [1];



Sessions(46).baseDir = 'July2013';
Sessions(46).name = '05July2013';
Sessions(46).saveTags = {[4 5],[ 10 11 12]};
Sessions(46).version = 'V012';
Sessions(46).UnitLabels(1).V = [1 2 3];
Sessions(46).UnitLabels(2).V = [1];
Sessions(46).Channels(1).V = [1 1 1];
Sessions(46).Channels(2).V = [1];


Sessions(47).baseDir = 'August2013';
Sessions(47).name = '21August2013';
Sessions(47).saveTags = {[4],[6]};
Sessions(47).version = 'V012';
Sessions(47).UnitLabels(1).V = [1];
Sessions(47).UnitLabels(2).V = [1];
Sessions(47).Channels(1).V = [1];
Sessions(47).Channels(2).V = [1];


% Sessions(48).baseDir = 'August2013';
% Sessions(48).name = '22August2013';
% Sessions(48).saveTags = {[7]};
% Sessions(48).version = 'V012';
% Sessions(48).UnitLabels(1).V = [-1];

Sessions(48).baseDir = 'August2013';
Sessions(48).name = '23August2013';
Sessions(48).saveTags = {[6:10]};
Sessions(48).version = 'V012';
Sessions(48).UnitLabels(1).V = [-1];
Sessions(48).Channels(1).V = [1];



Sessions(49).baseDir = 'August2013';
Sessions(49).name = '28August2013';
Sessions(49).saveTags = {[3], [5], [8], [10 11]};
Sessions(49).version = 'V012';
Sessions(49).UnitLabels(1).V = [1];
Sessions(49).UnitLabels(2).V = [1];
Sessions(49).UnitLabels(3).V = [1];
Sessions(49).UnitLabels(4).V = [1];

Sessions(49).Channels(1).V = [1];
Sessions(49).Channels(2).V = [1];
Sessions(49).Channels(3).V = [1];
Sessions(49).Channels(4).V = [1];

Sessions(50).baseDir = 'August2013';
Sessions(50).name = '29August2013';
Sessions(50).saveTags = {[3 5], [8]};
Sessions(50).version = 'V012';
Sessions(50).UnitLabels(1).V = [1 1];
Sessions(50).Channels(1).V = [1 3];
Sessions(50).UnitLabels(1).V = [1 1];
Sessions(50).Channels(1).V = [1 3];

Sessions(50).baseDir = 'August2013';
Sessions(50).name = '29August2013';
Sessions(50).saveTags = {[3 5], [8]};
Sessions(50).version = 'V012';
Sessions(50).UnitLabels(1).V = [1 1];
Sessions(50).Channels(1).V = [1 3];
Sessions(50).UnitLabels(1).V = [1 1];
Sessions(50).Channels(1).V = [1 3];


Sessions(50).baseDir = 'September2013';
Sessions(50).name = '18September2013';
Sessions(50).saveTags = {[3 4], [10]};
Sessions(50).version = 'V012';
Sessions(50).UnitLabels(1).V = [1 2];
Sessions(50).UnitLabels(2).V = [1];

Sessions(50).Channels(1).V = [1 1];
Sessions(50).Channels(2).V = [1];

% Sessions(51).baseDir = 'September2013';
% Sessions(51).name = '18September2013';
% Sessions(51).saveTags = {[3 4], [10]};
% Sessions(51).version = 'V012';
% Sessions(51).UnitLabels(1).V = [1 2];
% Sessions(51).UnitLabels(2).V = [1];
% Sessions(51).Channels(1).V = [1 1];
% Sessions(51).Channels(2).V = [1];


Sessions(51).baseDir = 'September2013';
Sessions(51).name = '19September2013';
Sessions(51).saveTags = {[3 4], [7]};
Sessions(51).version = 'V012';
Sessions(51).UnitLabels(1).V = [1];
Sessions(51).UnitLabels(2).V = [1];
Sessions(51).Channels(1).V = [1];
Sessions(51).Channels(2).V = [1];


Sessions(51).baseDir = 'September2013';
Sessions(51).name = '19September2013';
Sessions(51).saveTags = {[3 4], [7]};
Sessions(51).version = 'V012';
Sessions(51).UnitLabels(1).V = [1];
Sessions(51).UnitLabels(2).V = [1];
Sessions(51).Channels(1).V = [1];
Sessions(51).Channels(2).V = [1];

% Start of U-probe sessions

Sessions(52).baseDir = 'October2013';
Sessions(52).name = '14October2013';
Sessions(52).saveTags = {[3:8]};
Sessions(52).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/14October2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(52).Channels(1).V = S{1}(temp);
Sessions(52).UnitLabels(1).V = S{2}(temp);


Sessions(53).baseDir = 'November2013';
Sessions(53).name = '29November2013';
Sessions(53).saveTags = {[2:6]};
Sessions(53).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/29November2013_Sorted.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(53).Channels(1).V = S{1}(temp);
Sessions(53).UnitLabels(1).V = S{2}(temp);


Sessions(54).baseDir = 'November2013';
Sessions(54).name = '25November2013';
Sessions(54).saveTags = {[4 5 6]}; % 2 is omitted due to different saveTag
Sessions(54).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/25November2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(54).Channels(1).V = S{1}(temp);
Sessions(54).UnitLabels(1).V = S{2}(temp);
fclose(fid);


Sessions(55).baseDir = 'October2013';
Sessions(55).name = '11October2013';
Sessions(55).saveTags = {[3:4]}; % 2 is omitted due to different saveTag
Sessions(55).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/11October2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(55).Channels(1).V = S{1}(temp);
Sessions(55).UnitLabels(1).V = S{2}(temp);
fclose(fid);


Sessions(56).baseDir = 'October2013';
Sessions(56).name = '15October2013';
Sessions(56).saveTags = {[2:4]};
Sessions(56).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/15October2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(56).Channels(1).V = S{1}(temp);
Sessions(56).UnitLabels(1).V = S{2}(temp);
fclose(fid);


Sessions(57).baseDir = 'October2013';
Sessions(57).name = '16October2013';
Sessions(57).saveTags = {[6:8]};
Sessions(57).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/16October2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(57).Channels(1).V = S{1}(temp);
Sessions(57).UnitLabels(1).V = S{2}(temp);
fclose(fid);


Sessions(58).baseDir = 'November2013';
Sessions(58).name = '26November2013';
Sessions(58).saveTags = {[3:6]};
Sessions(58).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/26November2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(58).Channels(1).V = S{1}(temp);
Sessions(58).UnitLabels(1).V = S{2}(temp);
fclose(fid);

Sessions(59).baseDir = 'December2013';
Sessions(59).name = '02December2013';
Sessions(59).saveTags = {[2:4]};
Sessions(59).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/02December2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(59).Channels(1).V = S{1}(temp);
Sessions(59).UnitLabels(1).V = S{2}(temp);
fclose(fid);


Sessions(60).baseDir = 'December2013';
Sessions(60).name = '03December2013';
Sessions(60).saveTags = {[2:4]};
Sessions(60).version = 'V015';
fid = fopen('/net/home/chand/code/rig5analysis/lists/03December2013.txt','r');
S = textscan(fid,'%d%d','delimiter',',','headerlines',4);
temp = find(S{1} <=16);
Sessions(60).Channels(1).V = S{1}(temp);
Sessions(60).UnitLabels(1).V = S{2}(temp);
fclose(fid);


Sessions(61).baseDir = 'March2014';
Sessions(61).name = '07March2014';
Sessions(61).saveTags = {[2:4]};
Sessions(61).version = 'V015';
Sessions(61).Channels(1).V = [4 14];
Sessions(61).UnitLabels(1).V = [1 2];


Sessions(62).baseDir = 'March2014';
Sessions(62).name = '06March2014';
Sessions(62).saveTags = {[9:11]};
Sessions(62).version = 'V015';
Sessions(62).Channels(1).V =   [16 16 12 11  8 7 7 6 6 4];
Sessions(62).UnitLabels(1).V = [ 1  2  1  2  1 2 1 1 2 1];


Sessions(63).baseDir = 'March2014';
Sessions(63).name = '05March2014';
Sessions(63).saveTags = {[1:6]};
Sessions(63).version = 'V015';
Sessions(63).Channels(1).V =   [1 3 4 4 7 8 9 9 10 11 12 13 14 14 14 15 15];
Sessions(63).UnitLabels(1).V = [1 1 1 2 1 1 2 1  1  1  1  1  1  2 3   1  3];

Sessions(64).baseDir = 'March2014';
Sessions(64).name = '04March2014';
Sessions(64).saveTags = {[1:6]};
Sessions(64).version = 'V015';
Sessions(64).Channels(1).V =   [9 9 10 11 12 13 14 15 16 ];
Sessions(64).UnitLabels(1).V = [1 2  1  2  1  1  2  2  1];

Sessions(65).baseDir = 'March2014';
Sessions(65).name = '03March2014';
Sessions(65).saveTags = {[4:5]};
Sessions(65).version = 'V015';
Sessions(65).Channels(1).V =   [8 8 9 9 10 10 11 12 12 14 14];
Sessions(65).UnitLabels(1).V = [1 2 2 2  1  2  1  2  3  1  2];

Sessions(66).baseDir = 'February2014';
Sessions(66).name = '28February2014';
Sessions(66).saveTags = {[1:7]};
Sessions(66).version = 'V015';
Sessions(66).Channels(1).V =   [1 6 8 8 9 9 10 10 10 11 13 13];
Sessions(66).UnitLabels(1).V = [1 1 2 1 1 2  1  2  3  1  1  2] ;

Sessions(67).baseDir = 'February2014';
Sessions(67).name = '27February2014';
Sessions(67).saveTags = {[3:6]};
Sessions(67).version = 'V015';
Sessions(67).Channels(1).V =   [16 16 15 14 14 13 13 13 13 12 12 11 10  9 9  8 5 4 3 2];
Sessions(67).UnitLabels(1).V = [ 1  2  1  1  2  1  2  3  4  1  2  2  1  1 2  1 1 1 1 1] ;

Sessions(68).baseDir = 'February2014';
Sessions(68).name = '26February2014';
Sessions(68).saveTags = {[1:5]};
Sessions(68).version = 'V015';
Sessions(68).Channels(1).V =   [16 16 15 12 11 7 6 4 3];
Sessions(68).UnitLabels(1).V = [ 1  2  2  1  1 1 1 1 1] ;

Sessions(69).baseDir = 'December2013';
Sessions(69).name = '18December2013';
Sessions(69).saveTags = {[3:6]};
Sessions(69).version = 'V015';
Sessions(69).Channels(1).V =   [2 3 4 5 6 6 7 8 9 10 10 13 14 15 16 16 ];
Sessions(69).UnitLabels(1).V = [3 2 1 1 1 2 1 1 1  1  2  1  2  1  1  2 ];

Sessions(69).baseDir = 'December2013';
Sessions(69).name = '17December2013';
Sessions(69).saveTags = {[2:4]};
Sessions(69).version = 'V015';
Sessions(69).Channels(1).V =   [3 3 3 4 4 5 6 7 8 9 10 14 16 16 ];
Sessions(69).UnitLabels(1).V = [3 2 1 2 1 1 1 1 1 1  1  2  1  2 ];

Sessions(70).baseDir = 'December2013';
Sessions(70).name = '21December2013';
Sessions(70).saveTags = {[2:4]};
Sessions(70).version = 'V015';
Sessions(70).Channels(1).V =   [2 4 6 6 7 7 8 9 12];
Sessions(70).UnitLabels(1).V = [1 1 1 2 1 2 1 1 1];

Sessions(71).baseDir = 'December2013';
Sessions(71).name = '16December2013';
Sessions(71).saveTags = {[2:4]};
Sessions(71).version = 'V015';
Sessions(71).Channels(1).V =   [1 3 4  6 7 7 12 13 15 15 16];
Sessions(71).UnitLabels(1).V = [2 1 2  1 1 2  1  3  1  2  1];

Sessions(72).baseDir = 'December2013';
Sessions(72).name = '09December2013';
Sessions(72).saveTags = {[2:5]};
Sessions(72).version = 'V015';
Sessions(72).Channels(1).V =   [2 3 4 4 5 6 7 8 8 9 10 10 12 13 16];
Sessions(72).UnitLabels(1).V = [1 1 1 2 1 1 1 1 2 2  1  2  1  1 2];

Sessions(73).baseDir = 'December2013';
Sessions(73).name = '12December2013new';
Sessions(73).saveTags = {[3:8]};
Sessions(73).version = 'V015';
Sessions(73).Channels(1).V =   [2 3 4 4 5 5 5 5 6 7 8 9 10 10];
Sessions(73).UnitLabels(1).V = [1 1 1 2 1 2 3 4 2 1 1 1  1  2] ;

Sessions(74).baseDir = 'December2013';
Sessions(74).name = '13December2013';
Sessions(74).saveTags = {[3:8]};
Sessions(74).version = 'V015';
Sessions(74).Channels(1).V =   [16 16 15 7 8 9 9 10 10 11 11 13 14];
Sessions(74).UnitLabels(1).V = [ 1  2  1 2 1 1 2  1  3  1  2  2  1];


Sessions(75).baseDir = 'December2013';
Sessions(75).name = '04December2013';
Sessions(75).saveTags = {[4:6]};
Sessions(75).version = 'V015';
Sessions(75).Channels(1).V =   [3 4 5 6 7 8 9 10 11 11 14 16];
Sessions(75).UnitLabels(1).V = [1 1 1 1 2 1 1  1  1  2  1  1];

if 0
    Sessions(76).baseDir = 'October2013';
    Sessions(76).name = '11October2013';
    Sessions(76).saveTags = {[1:2]};
    Sessions(76).version = 'V015';
    Sessions(76).Channels(1).V =   [1 2 2 3 3 4 4 5 5 6 7 7 8 8 9 10 10  11  11 16];
    Sessions(76).UnitLabels(1).V = [1 1 2 1 2 1 2 1 2 1 1 2 1 2 1  1  2   1   2  1];
end

[~, sysname] = system('hostname');

for nS = 1:length(Sessions)
    Sessions(nS).getLFP = false;
    Sessions(nS).monkey = 'Tiberius';
    Sessions(nS).TaskName = '';
end


if ~strcmp(sysname,'rig5dataLogger')
    remoteDir = '/net/data/Tiberius/Data/dataLoggerFiles/';
    remoteScratch = '/net/derived/chand/';
    if ~exist(remoteScratch)
        mkdir(remoteScratch)
    end
    %     for nS = 1:4
    %         Sessions(nS).baseDir = 'January2013';
    %     end
    %
    %     for nS = 5:length(Sessions)
    %         Sessions(nS).baseDir = 'April2013';
    %     end
else
    remoteDir = '/data/ChandData/Tiberius/';
    for nS = 1:length(Sessions)
        Sessions(nS).baseDir = 'Tiberius';
        Sessions(nS).getLFP = false;
    end
end