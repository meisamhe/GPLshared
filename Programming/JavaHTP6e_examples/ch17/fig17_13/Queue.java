// Fig. 17.13: Queue.java
// Class Queue.
package com.deitel.jhtp6.ch17;

public class Queue 
{
   private List queueList;

   // no-argument constructor
   public Queue() 
   { 
      queueList = new List( "queue" ); 
   } // end Queue no-argument constructor

   // add object to queue
   public void enqueue( Object object )
   { 
      queueList.insertAtBack( object ); 
   } // end method enqueue

   // remove object from queue
   public Object dequeue() throws EmptyListException
   { 
      return queueList.removeFromFront(); 
   } // end method dequeue

   // determine if queue is empty
   public boolean isEmpty()
   {
      return queueList.isEmpty();
   } // end method isEmpty

   // output queue contents
   public void print()
   {
      queueList.print();
   } // end method print
} // end class Queue


/**************************************************************************
 * (C) Copyright 1992-2005 by Deitel & Associates, Inc. and               *
 * Pearson Education, Inc. All Rights Reserved.                           *
 *                                                                        *
 * DISCLAIMER: The authors and publisher of this book have used their     *
 * best efforts in preparing the book. These efforts include the          *
 * development, research, and testing of the theories and programs        *
 * to determine their effectiveness. The authors and publisher make       *
 * no warranty of any kind, expressed or implied, with regard to these    *
 * programs or to the documentation contained in these books. The authors *
 * and publisher shall not be liable in any event for incidental or       *
 * consequential damages in connection with, or arising out of, the       *
 * furnishing, performance, or use of these programs.                     *
 *************************************************************************/
