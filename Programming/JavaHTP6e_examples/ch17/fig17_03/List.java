// Fig. 17.3: List.java
// ListNode and List class definitions.
package com.deitel.jhtp6.ch17;

// class to represent one node in a list
class ListNode 
{
   // package access members; List can access these directly
   Object data;    
   ListNode nextNode;

   // constructor creates a ListNode that refers to object
   ListNode( Object object ) 
   { 
      this( object, null ); 
   } // end ListNode one-argument constructor 

   // constructor creates ListNode that refers to 
   // Object and to next ListNode
   ListNode( Object object, ListNode node )
   {
      data = object;    
      nextNode = node;  
   } // end ListNode two-argument constructor

   // return reference to data in node
   Object getObject() 
   { 
      return data; // return Object in this node
   } // end method getObject

   // return reference to next node in list
   ListNode getNext() 
   { 
      return nextNode; // get next node
   } // end method getNext
} // end class ListNode

// class List definition
public class List 
{
   private ListNode firstNode;
   private ListNode lastNode;
   private String name; // string like "list" used in printing

   // constructor creates empty List with "list" as the name
   public List() 
   { 
      this( "list" ); 
   } // end List no-argument constructor

   // constructor creates an empty List with a name
   public List( String listName )
   {
      name = listName;
      firstNode = lastNode = null;
   } // end List one-argument constructor

   // insert Object at front of List
   public void insertAtFront( Object insertItem )
   {
      if ( isEmpty() ) // firstNode and lastNode refer to same object
         firstNode = lastNode = new ListNode( insertItem );
      else // firstNode refers to new node
         firstNode = new ListNode( insertItem, firstNode );
   } // end method insertAtFront

   // insert Object at end of List
   public void insertAtBack( Object insertItem )
   {
      if ( isEmpty() ) // firstNode and lastNode refer to same Object
         firstNode = lastNode = new ListNode( insertItem );
      else // lastNode's nextNode refers to new node
         lastNode = lastNode.nextNode = new ListNode( insertItem );
   } // end method insertAtBack

   // remove first node from List
   public Object removeFromFront() throws EmptyListException
   {
      if ( isEmpty() ) // throw exception if List is empty
         throw new EmptyListException( name );

      Object removedItem = firstNode.data; // retrieve data being removed

      // update references firstNode and lastNode 
      if ( firstNode == lastNode )
         firstNode = lastNode = null;
      else
         firstNode = firstNode.nextNode;

      return removedItem; // return removed node data
   } // end method removeFromFront

   // remove last node from List
   public Object removeFromBack() throws EmptyListException
   {
      if ( isEmpty() ) // throw exception if List is empty
         throw new EmptyListException( name );

      Object removedItem = lastNode.data; // retrieve data being removed

      // update references firstNode and lastNode
      if ( firstNode == lastNode )
         firstNode = lastNode = null;
      else // locate new last node
      { 
         ListNode current = firstNode;

         // loop while current node does not refer to lastNode
         while ( current.nextNode != lastNode )
            current = current.nextNode;
   
         lastNode = current; // current is new lastNode
         current.nextNode = null;
      } // end else

      return removedItem; // return removed node data
   } // end method removeFromBack

   // determine whether list is empty
   public boolean isEmpty()
   { 
      return firstNode == null; // return true if List is empty
   } // end method isEmpty

   // output List contents
   public void print()
   {
      if ( isEmpty() ) 
      {
         System.out.printf( "Empty %s\n", name );
         return;
      } // end if

      System.out.printf( "The %s is: ", name );
      ListNode current = firstNode;

      // while not at end of list, output current node's data
      while ( current != null ) 
      {
         System.out.printf( "%s ", current.data );
         current = current.nextNode;
      } // end while

      System.out.println( "\n" );
   } // end method print
} // end class List

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
