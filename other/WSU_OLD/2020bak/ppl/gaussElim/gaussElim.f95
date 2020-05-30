!Adam Stammer
!Principles of Programming Languages
! - Winona State - Dr. Iyengar 2020

implicit none
double precision A(3,3), b(3), x(3) !left side, right side, answers
integer i,j !iterators

open(10, file = 'SIMEQ.DAT', status='old') !open input file
open(11, file = 'SOLV.DAT', status='replace') !open output file
read(10,*) A(1,1) !read # of variables/equations

!make sure the # of equations/variables is 3. close program if not
if (.NOT. (A(1,1) .EQ. 3)) then
	write(*,*) 'This program can only solve 3 variable systems. Exiting...'
    stop
end if

read(10,*) A(1,1), A(1,2), A(1,3), b(1) !read equation 1
read(10,*) A(2,1), A(2,2), A(2,3), b(2) !read equation 2
read(10,*) A(3,1), A(3,2), A(3,3), b(3) !read equation 3


write(*,*) 'Initial Matrix:'
do i=1,3
     write(*,*) (A(i,j),j=1,3), b(i) !print the matrix to the screen
end do

call gauss_2(A,b,x) !call the Gaussian Elimination function

write(*,*) 'Final Matrix:'

do i=1,3
     write(*,*) (A(i,j),j=1,3), b(i) !print final matrix to screen
end do

!print the solved varialbe values to the screen and output file
write(*,*) 'Solved Values: '
write(11,*) 'X = ', x(1)
write(*,*) 'X = ', x(1)

write(11,*) 'Y = ', x(2)
write(*,*) 'Y = ', x(2)

write(11,*) 'Z = ', x(3)
write(*,*) 'Z = ', x(3)

close(10) !close file pipes
close(11)

end !end program

subroutine gauss_2(A,b,x)
implicit none 
double precision A(3,3), b(3), x(3) ! left side, right side, answers
double precision f ! elimination factor variable
integer i, j, k ! iterators 

!Elimination Loop
do k=1, 2
   do i=k+1,3
      f=a(i,k)/a(k,k) !find the elimination factor
      a(i,k) = 0.0 ! eliminate
      b(i)=b(i)- f*b(k) !factor right side of equation
      do j=k+1,3 !factor the rest of the left side
         a(i,j) = a(i,j)-f*a(k,j)
      end do
   end do
end do




!Back Substitution
 
x(3) = b(3)/a(3,3) !solve for z


!Solve for x and y
do i=2,1,-1
   f=0.0
   do j=i+1,3
     f= f + a(i,j)*x(j)
   end do 
   x(i) = (b(i)- f)/a(i,i)
end do

end subroutine gauss_2