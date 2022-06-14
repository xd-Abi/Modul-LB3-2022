// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

struct Student
{
    string name;

    /* 
     We use string as the grade, because solidity does not 
     support any kind of float / double type.
    */ 

    string grade;
    
}

contract GradesLedger
{
    mapping (address => Student) private _students;

    constructor ()
    {}


    function add(address studentAddress, string memory name, string memory initialGrade) public 
    {
        set(studentAddress, name, initialGrade);
    }

    function remove(address studentAddress) public
    {
        delete _students[studentAddress];
    }

    function get(address studentAddress) public view returns (Student memory)
    {
        return _students[studentAddress];
    }

    function set(address studentAddress, string memory name, string memory grade) public
    {
        /**
         At the moment solidity does not support any kind of float / double type
         therefore we cant validate and the way its implemented the grade 
         can be set to '6.99' or even 'test'
        */ 

        require(bytes(grade)[0] != "0", "The grade must be greater than 1"); 
        require(bytes(grade)[0] != "7", "The grade exceeded the limit of 6");
        require(bytes(grade).length < 5, "The grade must be in this format: x.xx");

         _students[studentAddress] = Student(name, grade);
    }

}
