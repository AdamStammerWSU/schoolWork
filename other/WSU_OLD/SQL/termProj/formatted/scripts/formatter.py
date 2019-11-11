import pandas
import numpy
import sys
args=sys.argv
xl=pandas.read_excel(args[1])
xl=numpy.array(xl)
stateName=args[1][:-4].title()

print(stateName)
xl=xl[2:,1:]
noDataRow=23
for i in range(1,23):
    if xl[i][1] == '-' or xl[i][2] == '...' or xl[i][2] == "…" or xl[i][1] == "" or xl[i][2] == "":
        print("deleting data after row: ", i)
        noDataRow=i
        break
xl=xl[2:noDataRow]
xl2=numpy.zeros(len(xl)*4, dtype=object)
xl2.reshape(len(xl), 4)
for x in range(0, len(xl)):
    xl2[x]=numpy.append(xl[x], stateName)
header=numpy.array(["year", "population", "number_of_reps", "state_Name"])


xl2=numpy.hstack(xl2)[0:(len(xl)*4)].reshape(len(xl), 4)
pandas.DataFrame(xl2).to_csv("formatted/"+str(stateName)+".csv", index=False, header=header)
