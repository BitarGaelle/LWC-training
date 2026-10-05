//TODO #1  Declare a variable whose type is Course__c named newCourse  
//         and initialize it to a newly constructed Course__c sObject,
//         assigning the field Name the value '[104] Introduction to Programming',
//         the field Course_Description__c the value 'Learn the basics of programming with OOP',
//         the field Status__c the value 'Active',
//         the field Duration__c the value 5.

//TODO #2  Use the insert statement to insert newCourse into the database.

// Course__c newCourse = new Course__c();
// newCourse.Name = '[105] Introduction to Programming';
// newCourse.Description__c = 'Learn the basics of programming with OOP';
// newCourse.Status__c = 'Active';
// newCourse.Duration__c = 4;


// insert newCourse;

// Extension of 3.6
// You need to create an apex calss that contains a method.
// The method should take 2 parameters (course name and number of deliveries)
// You should call from execute anonymous the class and method to create a course
// with X deliveries related to this course where X is the number you gave in parameter.

public class Course_Delivery_Manager {

    public static ID addCourseDelivery(String CourseName, Integer numberOfDelivery) {
        for(Integer i = 0; i < numberOfDelivery; i++)
        {
            Course_Delivery__c cd = new Course_Delivery__c();
        }

    }
}

Course__c newCourse = new Course__c();
newCourse.Name = '[105] Introduction to Programming';
newCourse.Description__c = 'Learn the basics of programming with OOP';
newCourse.Status__c = 'Active';
newCourse.Duration__c = 4;