Program pascalProject;
Uses crt;
Var
  vOpt : Byte;
  // user selected menu option
  dbFile: TextFile;
  //database file
  s: String;
  // random string storage
  teamData: Array[0..50] Of Array[0..5] Of String;
  //stores team data
  playerData: Array[0..500] Of Array[0..11] Of String;
  //stores player data
  teamNumber: Integer;
  //how many teams are there?
  numberOfPlayers: Integer;
  //how many players are there?

Const
  ValidChars : set Of Char = ['0','1','2','3','4','5','6','7'];
  PlayerDataNames: Array[0..11] Of String = ('Team', 'Name', 'School', 'Age', 'Weight', 'Height',
                                             'Jersey #', 'Tel#', 'House#', 'Street', 'City',
                                             'Zip Code');
  TeamDataNames: Array[0..4] Of String = ('Name', 'Creation Date', 'Budget', '# of Players',
                                          'Win-Loss Record');
  FileName = 'TeamInfo.dat';

Function ReadUserOption: Byte;
Var
  InChar: Char;
  // which key did they hit
Begin
  Result := 255;
  //invalid char.
  Repeat
    InChar := Readkey;
    If InChar = #0 Then
      Begin
        InChar := Readkey;
        InChar := #255;
      End;
  Until (InChar In validChars) Or (InChar = #27);
  //escape to quit
  Result := Ord(InChar);
  If Result <> 27 Then Result := result - Ord('0');
End;
Procedure changeTeamBudget;
Var
  i: Integer;
Begin
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('Changing Team Budget');
  Writeln('Please Pick a Team');
  i := 0;
  While i < teamNumber+1 Do
    //list off all of the teams as a menu
    Begin
      Write(i);
      Writeln(': ' + teamData[i][0] + '['+teamData[i][2]+ ']');
      i := i + 1;
    End;
  Write('Your selection: ');
  vOpt := ReadUserOption;
  //have the user select one
  //0..7
  Writeln;
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Write('The existing budget for ' + teamData[vOpt][0] + 'is: ');
  //ask for new budget value
  Writeln(teamData[vOpt][2]);
  Write('What is the new budget?: ');
  Readln(s);
  teamData[vOpt][2] := s;
  //and store it
  Writeln;
  Writeln('Team Budget Update!');
End;
Procedure browseTeamList;
Var
  i: Integer;
Begin
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('Choose a team to see players');
  i := 0;
  While i < teamNumber+1 Do
    // display the teams as a menu
    Begin
      Write(i);
      Writeln(': ' + teamData[i][0] + '['+teamData[i][3]+ ']');
      i := i + 1;
    End;
  Write('Your selection: ');
  vOpt := ReadUserOption;
  //collect their response
  //0..7
  Writeln;
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  For i := 0 To 4 Do
    //list off all team data for the selected team
    Begin
      Writeln(teamDataNames[i] + ': ' + teamData[vOpt][i]);
    End;
  Writeln('Press Enter to Continue...');
  Readln;
End;
Procedure viewPlayerInfo;
Var
  i: Integer;
Begin
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('Select a player to see more info');
  i := 0;
  While i < numberOfPlayers Do
    //list off all of the players
    Begin
      Write(i);
      Writeln(': ' + playerData[i][1] + '['+playerData[i][0] + ', ' + playerData[i][6] + ']');
      i := i + 1;
    End;
  Write('Your selection: ');
  //record their selection
  vOpt := ReadUserOption;
  //0..7
  Writeln;
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  For i := 0 To 11 Do
    //and list off all data for the selected player
    Begin
      Writeln(playerDataNames[i] + ': ' + playerData[vOpt][i]);
    End;
  Writeln('Press Enter to Continue...');
  Readln;
End;
Procedure updateFile;
Var
  i: Integer;
  j: Integer;
  k: Integer;
  x: Integer;
  curLine: String;
Begin
  Clrscr;
  AssignFile(dbFile, FileName);
  //setup file for writing
  Rewrite(dbFile);
  For i:=0 To teamNumber Do
    //loop through each team
    Begin
      For j:=0 To 3 Do
        //print out the team data
        Begin
          Write(dbFile, teamData[i][j] + ^i);
        End;
      Writeln(dbFile, teamData[i][4]);
      //add the final piece of team data
      //loop through the players and add their data
      For j:=0 To numberOfPlayers Do
        //loop through all the players
        Begin
          If playerData[j][0] = teamData[i][0] Then //if the player belongs to this team
            Begin
              //print their data
              For k:= 1 To 10 Do
                Begin
                  Write(dbFile, playerData[j][k] + ^i);
                End;
              Writeln(dbFile, playerData[j][11]);
              //including the final piece
            End;
        End;
      Writeln(dbFile, '...');
      //finish up the file
    End;
  CloseFile(dbFile);
  //close it
  Writeln;
  Writeln;
  Writeln;
  Writeln('The file has been updated!');
  Write('Press "Enter" to conitnue:');
  Readln;
End;
Procedure changeTeamWLRecord;
Var
  i: Integer;
Begin
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('Changing Team Win-Loss Record');
  Writeln('Please Pick a Team');
  i := 0;
  While i < teamNumber+1 Do
    //list off the teams to choose from
    Begin
      Write(i);
      Writeln(': ' + teamData[i][0] + '['+teamData[i][4]+ ']');
      i := i + 1;
    End;
  Write('Your selection: ');
  vOpt := ReadUserOption;
  //record selection
  //0..7
  Writeln;
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Write('The existing Win-Loss Record for ' + teamData[vOpt][0] + ' is: ');
  Writeln(teamData[vOpt][4]);
  //ask for the new value
  Write('What is the new Win-Loss Record?: ');
  Readln(s);
  teamData[vOpt][4] := s;
  //and store it accordingly
  Writeln;
  Writeln('Team Win-Loss Record Update!');
End;

Procedure browsePlayerList;
Var
  i: Integer;
  j: Integer;
  k: Integer;
  x: Integer;
Begin
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  i := 0;
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('View Player List by Teams');
  Writeln('Please Pick a Team');
  i := 0;
  While i < teamNumber+1 Do
    //list off all of the teams to choose from
    Begin
      Write(i);
      Writeln(': ' + teamData[i][0] + '['+teamData[i][3]+ ']');
      i := i + 1;
    End;
  Write('Your selection: ');
  vOpt := ReadUserOption;
  //record selection
  //0..7
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  //print team data
  For j:=0 To 4 Do
    //list off the team data
    Begin
      Write(teamData[vOpt][j] + '    ');
    End;
  Writeln;
  //loop through all the players and print player data
  For k:=0 To numberOfPlayers Do
    Begin
      If playerData[k][0] = teamData[vOpt][0] Then //only if they're on the team selected
        Begin
          Write('      ');
          For x:= 1 To 6 Do
            Begin
              Write(playerData[k][x] + '  ');
            End;
          Writeln;
          Write('            ');
          //split the data onto 2 lines so it fits nice
          For x:= 7 To 10 Do
            Begin
              Write(playerData[k][x] + '  ');
            End;
          Writeln;
        End;
    End;
  Writeln;
  Write('Press Enter to Continue...');
  Readln;
End;

Procedure addPlayerToTeam;
Var
  i: Integer;
  input: String;
  u: Integer;
Begin
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('Adding Player to Team');
  Writeln('Please Pick a Team');
  i := 0;
  While i < teamNumber+1 Do
    //list all of the teams to choose from
    Begin
      Write(i);
      Writeln(': ' + teamData[i][0] + '['+teamData[i][3]+ ']');
      i := i + 1;
    End;
  Write('Your selection: ');
  vOpt := ReadUserOption;
  //0..7
  Writeln;
  Clrscr;
  Writeln;
  Writeln;
  Writeln;
  Writeln('Adding new Player to ' + teamData[vOpt][0]);
  Writeln('Fill in the information requested below');
  //create the new player in the player list
  playerData[numberOfPlayers][0] := teamData[vOpt][0];
  //set the team name for the player
  For i:= 1 To 11 Do
    //loop through all fields and have them set by the input values
    Begin
      Write(playerDataNames[i] + ': ');
      Readln(input);
      playerData[numberOfPlayers][i] := input;
    End;
  Writeln(playerData[numberOfPlayers][1] + ' has been added to Team ' + playerData[numberOfPlayers][
          0]);
  //increment the player count for the team
  Val(teamData[vOpt][3], i, u);
  Str(i+1, input);
  teamData[vOpt][3] := input;
  numberOfPlayers := numberOfPlayers + 1;
End;

Procedure readFromFile;
Var
  charNumber: Integer;
  //which character are you at in line
  lineNumber: Integer;
  //which line are you at
  playerNumber: Integer;
  //how many players are there
  numberOfLines: Integer;
  //how many lines to process
  i: Integer;
  //iterator
  continueLoop : Boolean;
  //should this line be 'processed' as a player or team
  newTeam : Boolean;
  //is this line a new team?
  readList: Array[0..500] Of String;
  //data read in line by line
  nextValue: String;
  // the next tab separated piece of data in a line
  c: Char;
  // the next character to process
  h: Char;
  //needed for numeric conversion at end of procedure
  dataNumber: Integer;
  //iterator
Begin
  numberOfPlayers := 0;
  //reset all counters
  playerNumber := 0;
  charNumber := 0;
  AssignFile(dbFile, FileName);
  //get file ready for read
  Reset(dbFile);
  i := 0;
  While Not Eof(dbFile) Do
    //read each line and store it in readLines
    Begin
      Readln(dbFile, readList[i]);
      readList[i] := readlist[i]+ '!';
      Write(i);
      Writeln(': ' + readList[i]);
      i := i+1;
    End;
  numberOfLines := i + 1;
  //TAB IS ASCII NUMBER DEC(9)
  lineNumber := 0;
  //reste counters
  newTeam := True;
  //assumes first line is a team
  While lineNumber < (numberOfLines - 2) Do
    //loop through each line
    Begin
      continueLoop := True;
      charNumber := 1;
      //reset variables
      s := '';
      c := readList[lineNumber][charNumber];
      //grab the first character
      If readList[lineNumber] = '...!' Then
        //if it's the ... line then the team is done, but a new team is next
        Begin
          teamNumber := teamNumber + 1;
          continueLoop := False;
          //so prepare the next loop to add a new team
          newTeam := True;
        End;
      If continueLoop Then //processable line (team or player)
        Begin
          If newTeam Then //add team
            Begin
              //process new team
              newTeam := False;
              charNumber := 1;
              nextValue := '';
              dataNumber := 0;
              c := readList[lineNumber][charNumber];
              h := Chr(9);
              While c <> '!' Do
                //go through the whole line of data
                Begin
                  If c = Chr(9) Then // word is finished (tab separated)
                    Begin
                      //store it properly
                      teamData[teamNumber][dataNumber] := nextValue;
                      dataNumber := dataNumber + 1;
                      nextValue := '';
                    End
                  Else
                    Begin
                      nextValue := nextValue + c;
                      //the word is not done so just build the characters up
                    End;
                  charNumber := charNumber + 1;
                  c := readList[lineNumber][charNumber];
                  //grab the next character
                End;
              //store the WinLoss Record
              teamData[teamNumber][4] := nextValue;
            End
          Else
            Begin
              //process new player
              Writeln('Processing new player from : ');
              Writeln(readList[lineNumber]);
              charNumber := 1;
              nextValue := '';
              playerData[playerNumber][0] := teamData[teamNumber][0];
              //store team name with the player
              dataNumber := 1;
              c := readList[lineNumber][charNumber];
              h := Chr(9);
              //again, tab separated
              While c <> '!' Do
                //read the whole line
                Begin
                  If c = Chr(9) Then // word is finished  (tab separated)
                    Begin
                      //store it properly
                      playerData[playerNumber][dataNumber] := nextValue;
                      dataNumber := dataNumber + 1;
                      nextValue := '';
                    End
                  Else
                    Begin
                      nextValue := nextValue + c;
                      //word's not done so just build the characters up
                    End;
                  charNumber := charNumber + 1;
                  c := readList[lineNumber][charNumber];
                  //grab the next character
                End;
              playerNumber := playerNumber + 1;
              numberOfPlayers := numberOfPlayers + 1;
              //increase counts
              //store the zip code
              playerData[playerNumber - 1][11] := nextValue;
            End;
        End;
      lineNumber := lineNumber + 1;
      //go onto the next line
    End;
End;
Begin
  readFromFile;
  Repeat
    Clrscr;
    //////main menu
    Writeln;
    Writeln;
    Writeln;
    Writeln('     0) Change Team Budget        4) Change Team Win-Loss Record');
    Writeln('     1) Browse Team List          5) Browse List From Team');
    Writeln('     2) View Player Info          6) Add Player to Team');
    Writeln('     3) Update File               7) Exit');
    Writeln;
    Write('Your selection or Esc to exit:');
    vOpt := ReadUserOption;
    //0..7
    Case vOpt Of
      0: changeTeamBudget;
      1: browseTeamList;
      2: viewPlayerInfo;
      3: updateFile;
      4: changeTeamWLRecord;
      5: browsePlayerList;
      6: addPlayerToTeam;
      7: Exit;
      27: ;
    End;
  Until vOpt = 27;
  //Escape to exit
End.
[code]
