program pascalProject;
uses crt;
var
  vOpt : Byte;
	dbFile: TextFile;
	s: String;
	splitString: Array[0..500] of String;
	teamData: array[0..50] of Array[0..5] of string;
	playerData: array[0..500] of Array[0..11] of string;
	teamNumber: Integer;
	numberOfPlayers: Integer;

const
	ValidChars :set of char = ['0','1','2','3','4','5','6','7'];
	PlayerDataNames: array[0..11] of string = ('Team', 'Name', 'School', 'Age', 'Weight', 'Height', 'Jersey #', 'Tel#', 'House#', 'Street', 'City', 'Zip Code');
	TeamDataNames: array[0..4] of string = ('Name', 'Creation Date', 'Budget', '# of Players', 'Win-Loss Record');
	FileName = 'TeamInfo.dat';

function ReadUserOption:Byte;
var
  InChar:Char;
	
begin
  Result := 255;//invalid char.
  repeat //Press Escape to exit;
   InChar := ReadKey;
   if InChar = #0 then begin InChar:=ReadKey; InChar:=#255; end;
  until (InChar in validChars) or (InChar = #27);
  Result := Ord(InChar);
  if Result <> 27 then Result := result - ord('0');
end;


Procedure changeTeamBudget;
Var
	i: Integer;
begin

  	ClrScr;
    writeln;writeln;writeln;
		writeLn('Changing Team Budget');
		writeLn('Please Pick a Team');
    i := 0;
		while i < teamNumber+1 Do
		Begin
				write(i);
				writeLn(': ' + teamData[i][0] + '['+teamData[i][2]+ ']');
				i := i + 1;
		end;
    write('Your selection: ');
    vOpt := ReadUserOption; //0..7
		writeLn;

		ClrScr;
		writeln;writeln;writeln;
  	write('The existing budget for ' + teamData[vOpt][0] + 'is: ');
		writeLn(teamData[vOpt][2]);

		write('What is the new budget?: ');
  	Readln(s);
		teamData[vOpt][2] := s;
		writeLn;
		writeLn('Team Budget Update!');
end;
Procedure browseTeamList;
Var
	i: Integer;
begin

  	ClrScr;
    writeln;writeln;writeln;
    i := 0;
		while i < teamNumber+1 Do
		Begin
				write(i);
				writeLn(': ' + teamData[i][0] + '['+teamData[i][3]+ ']');
				i := i + 1;
		end;
    write('Your selection: ');
    vOpt := ReadUserOption; //0..7
		writeLn;

		ClrScr;
		writeln;writeln;writeln;
  	for i := 0 to 4 Do
		Begin
				writeLn(teamDataNames[i] + ': ' + teamData[vOpt][i]);
		end;
		writeLn('Press Enter to Continue...');
  Readln;
end;
Procedure viewPlayerInfo;
Var
	i: Integer;
begin
  	ClrScr;
    writeln;writeln;writeln;
    i := 0;
		while i < numberOfPlayers Do
		Begin
				write(i);
				writeLn(': ' + playerData[i][1] + '['+playerData[i][0] + ', ' + playerData[i][6] + ']');
				i := i + 1;
		end;
    write('Your selection: ');
    vOpt := ReadUserOption; //0..7
		writeLn;

		ClrScr;
		writeln;writeln;writeln;
  	for i := 0 to 11 Do
		Begin
				writeLn(playerDataNames[i] + ': ' + playerData[vOpt][i]);
		end;
		writeLn('Press Enter to Continue...');
  Readln;
end;
Procedure updateFile;
Var
	i:Integer;
	j:Integer;
	k:Integer;
	x:Integer;
	curLine:String;
begin
  ClrScr;

		AssignFile(dbFile, FileName);

		{$I+}


    // Create the file, write some text and close it.
    rewrite(dbFile);

		for i:=0 to teamNumber Do
		Begin
				for j:=0 to 3 Do
				Begin
				write(dbFile, teamData[i][j] + ^i);
				end;
				writeLn(dbFile, teamData[i][4]); //add the final piece of team data

				//loop through the players and add their data
				for j:=0 to numberOfPlayers Do
				Begin
						if playerData[j][0] = teamData[i][0] Then  //if the player belongs to this team
						Begin
								//print their data
								for k:= 1 to 10 Do
								Begin
									write(dbFile, playerData[j][k] + ^i);
								end;
								writeLn(dbFile, playerData[j][11]);
						end;
				end;

				writeLn(dbFile, '...');
		end;

    CloseFile(dbFile);
	
  write('Press "Enter" to conitnue:');
  Readln;
end;
Procedure changeTeamWLRecord;
Var
	i: Integer;
begin

  	ClrScr;
    writeln;writeln;writeln;
		writeLn('Changing Team Win-Loss Record');
		writeLn('Please Pick a Team');
    i := 0;
		while i < teamNumber+1 Do
		Begin
				write(i);
				writeLn(': ' + teamData[i][0] + '['+teamData[i][4]+ ']');
				i := i + 1;
		end;
    write('Your selection: ');
    vOpt := ReadUserOption; //0..7
		writeLn;

		ClrScr;
		writeln;writeln;writeln;
  	write('The existing Win-Loss Record for ' + teamData[vOpt][0] + ' is: ');
		writeLn(teamData[vOpt][4]);

		write('What is the new Win-Loss Record?: ');
  	Readln(s);
		teamData[vOpt][4] := s;
		writeLn;
		writeLn('Team Win-Loss Record Update!');
end;

Procedure browsePlayerList;
var
	i:Integer;
	j:Integer;
	k:Integer;
	x:Integer;
Begin
		ClrScr;
		writeln;writeln;writeln;
		i := 0;

		  	ClrScr;
    writeln;writeln;writeln;
		writeLn('View Player List by Teams');
		writeLn('Please Pick a Team');
    i := 0;
		while i < teamNumber+1 Do
		Begin
				write(i);
				writeLn(': ' + teamData[i][0] + '['+teamData[i][4]+ ']');
				i := i + 1;
		end;
    write('Your selection: ');
    vOpt := ReadUserOption; //0..7
		ClrScr;
		writeLn;writeLn;writeLn;

				//print team data
				for j:=0 to 4 Do
				Begin
						write(teamData[vOpt][j] + '    ');
				end;
				writeln;
				//loop through all the players and print player data
				for k:=0 to numberOfPlayers Do
				Begin
						if playerData[k][0] = teamData[vOpt][0] Then
						Begin
								write('      ');
								for x:= 1 to 6 Do
								Begin
									write(playerData[k][x] + '  ');
								end;
								writeln;
								write('            ');
								for x:= 7 to 10 Do
								Begin
									write(playerData[k][x] + '  ');
								end;
								writeln;
						end;
				end;
				writeLn;
		
		write('Press Enter to Continue...');
		readln;
end;

Procedure addPlayerToTeam;
Var
	i:Integer;
	input: String;
	u: integer;
begin
  ClrScr;
    writeln;writeln;writeln;
		writeLn('Adding Player to Team');
		writeLn('Please Pick a Team');
    i := 0;
		while i < teamNumber+1 Do
		Begin
				write(i);
				writeLn(': ' + teamData[i][0] + '['+teamData[i][3]+ ']');
				i := i + 1;
		end;
    write('Your selection: ');
    vOpt := ReadUserOption; //0..7
		writeLn;

		ClrScr;
		writeln;writeln;writeln;

		writeLn('Adding new Player to ' + teamData[vOpt][0]);
		writeLn('Fill in the information requested below');

		//create the new player in the player list
		playerData[numberOfPlayers][0] := teamData[vOpt][0];//set the team name for the player

		for i:= 1 to 11 Do
		Begin
			write(playerDataNames[i] + ': ');
			readLn(input);
			playerData[numberOfPlayers][i] := input;
		end;
		writeLn(playerData[numberOfPlayers][1] + ' has been added to Team ' + playerData[numberOfPlayers][0]);
		//increment the player count for the team
		Val(teamData[vOpt][3], i, u);
		Str(i+1, input);
		teamData[vOpt][3] := input;

		numberOfPlayers := numberOfPlayers + 1;
end;

Procedure readFromFile;
Var
	charNumber: Integer;
	lineNumber: Integer;
	playerNumber: Integer;
	numberOfLines: Integer;
	i: Integer;
	continueLoop : Boolean;
	newTeam : Boolean;
	readList: array[0..500] of string;
	splitList: array[0..500] of string;
	nextValue: string;
	c: char;
	h: char;
	dataNumber: Integer;
Begin
	numberOfPlayers:= 0;
	playerNumber := 0;
	charNumber:= 0;
	AssignFile(dbFile, FileName);
	reset(dbFile);
	i := 0;
	while not eof(dbFile) do
	Begin
		readln(dbFile, readList[i]);
		readList[i] := readlist[i]+ '!';
		write(i);
		writeln(': ' + readList[i]);
		i := i+1;
	End;
	numberOfLines := i + 1;
	//TAB IS ASCII NUMBER DEC(9)

	lineNumber:= 0;
	newTeam := true;
	while lineNumber < (numberOfLines - 2) Do
	begin
		continueLoop := true;
		charNumber := 1;
		s := '';
		c := readList[lineNumber][charNumber];
		if readList[lineNumber] = '...!' Then
		begin
			write('new line indicator at line ');
			writeLn(lineNumber);
			teamNumber := teamNumber + 1;
			continueLoop := false;
			newTeam := true;
		end;


		
		if continueLoop then
		Begin
			if newTeam Then
			Begin
					 //process new team
					 writeLn('Processing New Team On: ');
					 writeLn(readList[lineNumber]);
					 newTeam := false;
					 charNumber := 1;
					 nextValue:= '';
					 dataNumber := 0;
					 c := readList[lineNumber][charNumber];
					 h := chr(9);
	
	
						 while c <> '!' do
						 Begin
								if c = chr(9) Then // word is finished
								Begin
									//store it properly
									write('Storing Team ' + nextValue + ' at ');
									write(teamNumber);
									write(', ');
									writeLn(dataNumber);
									teamData[teamNumber][dataNumber] := nextValue;
									dataNumber := dataNumber + 1;
									nextValue := '';
								end
								Else
								Begin
									nextValue := nextValue + c;
								end;
	
									charNumber := charNumber + 1;
									c := readList[lineNumber][charNumber];
						 end;
			
						//store the WinLoss Record
						teamData[teamNumber][4] := nextValue;
			End
			else
			Begin
						//process new player
				writeLn('Processing new player from : ');
				writeLn(readList[lineNumber]);

				charNumber := 1;
				nextValue:= '';
				playerData[playerNumber][0] := teamData[teamNumber][0]; //store team name with the player
				dataNumber := 1;
				c := readList[lineNumber][charNumber];
				h := chr(9);
				while c <> '!' do
					 Begin
							if c = chr(9) Then // word is finished
							Begin
								//store it properly
								write('Storing Player ' + nextValue + ' at ');
								write(playerNumber);
								write(', ');
								writeLn(dataNumber);
								playerData[playerNumber][dataNumber] := nextValue;
								dataNumber := dataNumber + 1;
								nextValue := '';
							end
							Else
							Begin
								nextValue := nextValue + c;
							end;

								charNumber := charNumber + 1;
								c := readList[lineNumber][charNumber];
					 end;
					 playerNumber := playerNumber + 1;
					 numberOfPlayers := numberOfPlayers + 1;
						//store the zip code
						playerData[playerNumber - 1][11] := nextValue;
			end;

			
		
		end;
		lineNumber := lineNumber + 1;
		

		
	end;

End;

begin

	readFromFile;



  repeat
    ClrScr;
    writeln;writeln;writeln;
    writeln('     0) Change Team Budget        4) Change Team Win-Loss Record');
    writeln('     1) Browse Team List          5) Browse List From Team');
    writeln('     2) View Player Info          6) Add Player to Team');
    writeln('     3) Update File               7) Exit');
    writeln;
    write('Your selection or Esc to exit:');
    vOpt := ReadUserOption; //0..7
    case vOpt of
      0: changeTeamBudget;
      1: browseTeamList;
      2: viewPlayerInfo;
      3: updateFile;
      4: changeTeamWLRecord;
      5: browsePlayerList;
      6: addPlayerToTeam;
      7: exit;
      27: ;
    end;
  until vOpt = 27;
end.
[code]
