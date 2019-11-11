use census2;

CREATE VIEW northeast AS
SELECT *
FROM state_measure
WHERE state_name = "Connecticut" or
	  state_name = "Maine" or
	  state_name = "Massachusetts" or
	  state_name = "New Hampshire" or
	  state_name = "Rhode Island" or
	  state_name = "Vermont" or
	  state_name = "New York" or
	  state_name = "New Jersey" or
	  state_name = "Pennsylvania";

CREATE VIEW midwest AS
SELECT *
FROM state_measure
WHERE state_name = "Iowa" or
	  state_name = "Kansas" or
	  state_name = "Minnesota" or
	  state_name = "Missouri" or
	  state_name = "Nebraska" or
	  state_name = "North Dakota" or
	  state_name = "South Dakota" or
	  state_name = "Illinois" or
	  state_name = "Indiana" or
	  state_name = "Michigan" or
	  state_name = "Ohio" or
	  state_name = "Wisconsin";
      
CREATE VIEW south AS
SELECT *
FROM state_measure
WHERE state_name = "Delaware" or
	  state_name = "Florida" or
	  state_name = "Georgia" or
	  state_name = "Maryland" or
	  state_name = "North Carolina" or
	  state_name = "South Carolina" or
	  state_name = "Virginia" or
	  state_name = "West Virginia" or
	  state_name = "Alabama" or
	  state_name = "Kentucky" or
	  state_name = "Mississippi" or
	  state_name = "Tennessee" or
	  state_name = "Arkansas" or
	  state_name = "Louisiana" or
	  state_name = "Oklahoma" or
	  state_name = "Texas";
      
CREATE VIEW west AS
SELECT *
FROM state_measure
WHERE state_name = "Arizona" or
	  state_name = "Colorado" or
	  state_name = "Idaho" or
	  state_name = "Montana" or
	  state_name = "Nevada" or
	  state_name = "New Mexico" or
	  state_name = "Utah" or
	  state_name = "Wyoming" or
	  state_name = "Alaska" or
	  state_name = "California" or
	  state_name = "Hawaii" or
	  state_name = "Oregon" or
	  state_name = "Washington";
      