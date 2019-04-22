Two sum problem
****
Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].
 

class Solution:
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        visited = {}
        for i in range(len(nums)):
            if '%s'%nums[i] in visited:
                return [i, visited['%s'%nums[i]]]
            else:
                visited['%s'%(target-nums[i])] = i
        return []

-----------------

125. Valid Palindrome
***
Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Note: For the purpose of this problem, we define empty string as valid palindrome.

Example 1:

Input: "A man, a plan, a canal: Panama"
Output: true
Example 2:

Input: "race a car"
Output: false

class Solution:
    def isPalindrome(self, s):
        """
        :type s: str
        :rtype: bool
        """
        string_array = []
        for char in s:
            if (ord(char)>=ord('a') and ord(char)<=ord('z')) or (ord(char)>=ord('A') and ord(char)<=ord('Z')) or (ord(char)>=ord('0') and ord(char)<=ord('9')):
                string_array.append(char.lower())
        if len(string_array) == 0:
            return True
        for i in range(len(string_array)):
            if string_array[i]!=string_array[-(i+1)]:
                return False
        return True
----------

8. String to Integer (atoi)
Implement atoi which converts a string to an integer.

The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned.

Note:

Only the space character ' ' is considered as whitespace character.
Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.
Example 1:

Input: "42"
Output: 42
Example 2:

Input: "   -42"
Output: -42
Explanation: The first non-whitespace character is '-', which is the minus sign.
             Then take as many numerical digits as possible, which gets 42.
Example 3:

Input: "4193 with words"
Output: 4193
Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.
Example 4:

Input: "words and 987"
Output: 0
Explanation: The first non-whitespace character is 'w', which is not a numerical 
             digit or a +/- sign. Therefore no valid conversion could be performed.
Example 5:

Input: "-91283472332"
Output: -2147483648
Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
             Thefore INT_MIN (−231) is returned.

class Solution:
    def myAtoi(self, str):
        """
        :type str: str
        :rtype: int
        """
        candidate = str.strip()
        if (len(candidate)==0):
            return 0
        output = 0
        sign = 1
        if candidate[0]=='-' or candidate[0]=='+' or (ord(candidate[0])>=ord('0') and ord(candidate[0])<=ord('9')):
            if  (ord(candidate[0])>=ord('0') and ord(candidate[0])<=ord('9')):
                output = ord(candidate[0]) - ord('0')
            elif candidate[0]=='-':
                sign = -1
            cur_index = 1
            while (cur_index < len(candidate)) and (ord(candidate[cur_index])>=ord('0') and ord(candidate[cur_index])<=ord('9')):
                output = output * 10 + (ord(candidate[cur_index]) - ord('0'))* sign
                cur_index += 1
                if output < -2**31:
                    return -2**31
                if output> 2**31 -1:
                    return 2**31 -1
                if cur_index > len(candidate):
                    break
        else:
            return 0
        return output
-------

344. Reverse String
Write a function that reverses a string. The input string is given as an array of characters char[].

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

You may assume all the characters consist of printable ascii characters.

 

Example 1:

Input: ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
Example 2:

Input: ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]

class Solution:
    def reverseString(self, s):
        """
        :type s: str
        :rtype: str
        """
        output = ""
        for i in range(len(s)):
            output += s[-(i+1)]
        return output
------

151. Reverse Words in a String
Given an input string, reverse the string word by word.

Example:  

Input: "the sky is blue",
Output: "blue is sky the".
Note:

A word is defined as a sequence of non-space characters.
Input string may contain leading or trailing spaces. However, your reversed string should not contain leading or trailing spaces.
You need to reduce multiple spaces between two words to a single space in the reversed string.
Follow up: For C programmers, try to solve it in-place in O(1) space.

class Solution(object):
    def reverseWords(self, s):
        """
        :type s: str
        :rtype: str
        """
        list_of_words = s.strip().split(" ")
        if len(list_of_words)==0:
            return ""
        if len(list_of_words)==1:
            return list_of_words[0]
        output_list = []
        for i in range(len(list_of_words)):
            if len(list_of_words[-(i+1)])!=0 and list_of_words[-(i+1)]!=' ':
                output_list.append(list_of_words[-(i+1)].strip())
        return " ".join(output_list)

----------

186. Reverse Words in a String II.
Given an input string , reverse the string word by word. 

Example:

Input:  ["t","h","e"," ","s","k","y"," ","i","s"," ","b","l","u","e"]
Output: ["b","l","u","e"," ","i","s"," ","s","k","y"," ","t","h","e"]
Note: 

A word is defined as a sequence of non-space characters.
The input string does not contain leading or trailing spaces.
The words are always separated by a single space.
Follow up: Could you do it in-place without allocating extra space?

class Solution(object):
    def reverseWords(self, str):
        """
        :type str: List[str]
        :rtype: void Do not return anything, modify str in-place instead.
        """
        for i in range(len(str)//2):
            str[i], str[-(i+1)] = str[-(i+1)], str[i]
        start = 0
        cur_end = 0
        while cur_end <len(str):
            if str[cur_end]==" ":
                for i in range((cur_end-start)//2):
                    str[start+i], str[cur_end-(i+1)] = str[cur_end-(i+1)], str[start+i]
                start = cur_end+1
            cur_end+=1 
        for i in range((cur_end-start)//2):
             str[start+i], str[cur_end-(i+1)] = str[cur_end-(i+1)], str[start+i]
        
---------------
20. Valid Parentheses.

Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
Note that an empty string is also considered valid.

Example 1:

Input: "()"
Output: true
Example 2:

Input: "()[]{}"
Output: true
Example 3:

Input: "(]"
Output: false
Example 4:

Input: "([)]"
Output: false
Example 5:

Input: "{[]}"
Output: true

class Solution(object):
    def isValid(self, s):
        """
        :type s: str
        :rtype: bool
        """
        if str=="":
            return True
        stack = []
        complement = {'(':')','{':'}', '[':']'}
        for i in range(len(s)):
            if s[i] in ['(', '{', '[']:
                stack.append(s[i])
            else:
                if len(stack)>0 and complement[stack[-1]]==s[i]:
                    del stack[-1]
                else:
                    return False
        if len(stack)==0:
            return True
        else:
            return False


-----------------

5. Longest Palindromic Substring.

Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

Example 1:

Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.
Example 2:

Input: "cbbd"
Output: "bb"

class Solution(object):
    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        longest_palindrom = ""
        for i in range(len(s)):
            start = i 
            end = i
            while s[start]==s[end] and start>=1 and end<=len(s)-2:
                start -=1
                end +=1
            if s[start]!=s[end]:
                start +=1
                end -=1   
            if len(s[start:(end+1)])>len(longest_palindrom):
                longest_palindrom = s[start:(end+1)]
            if i<len(s) -1:
                start = i 
                end = i+1
                while s[start]==s[end] and start>=1 and end<=len(s)-2:
                    start -=1
                    end +=1
                if s[start]!=s[end]:
                    start +=1
                    end -=1   
                if s[start]==s[end] and len(s[start:(end+1)])>len(longest_palindrom):
                    longest_palindrom = s[start:(end+1)]
        return longest_palindrom

-----------

49. Group Anagrams.
Given an array of strings, group anagrams together.

Example:

Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
Output:
[
  ["ate","eat","tea"],
  ["nat","tan"],
  ["bat"]
]
Note:

All inputs will be in lowercase.
The order of your output does not matter.

class Solution(object):
    def groupAnagrams(self, strs):
        """
        :type strs: List[str]
        :rtype: List[List[str]]
        """
        anagram_dictionary = {}
        output = []
        for s in strs:
            cur_value = list(s)
            cur_value.sort()
            cur_value = "".join(cur_value)
            if cur_value in anagram_dictionary.keys():
                anagram_dictionary[cur_value] = anagram_dictionary[cur_value] + [s]
            else:
                anagram_dictionary[cur_value] = [s]
        for key in anagram_dictionary.keys():
            output.append(anagram_dictionary[key])
        return output

-----------

49. Group Anagrams

Given an array of strings, group anagrams together.

Example:

Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
Output:
[
  ["ate","eat","tea"],
  ["nat","tan"],
  ["bat"]
]
Note:

All inputs will be in lowercase.
The order of your output does not matter.


class Solution(object):
    def groupAnagrams(self, strs):
        """
        :type strs: List[str]
        :rtype: List[List[str]]
        """
        anagram_dictionary = {}
        output = []
        for s in strs:
            cur_value = "".join(sorted(s))
            if cur_value in anagram_dictionary.keys():
                anagram_dictionary[cur_value] = anagram_dictionary[cur_value] + [s]
            else:
                anagram_dictionary[cur_value] = [s]
        for key in anagram_dictionary.keys():
            output.append(anagram_dictionary[key])
        return output
---------


42. Trapping Rain Water
Hard

2846

50

Favorite

Share
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.


The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

Example:

Input: [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6


class Solution(object):
    def trap(self, height):
        """
        :type height: List[int]
        :rtype: int
        """
        if len(height)==0:
            return 0
        water_level = 0
        left = 0
        right = len(height)-1
        while len(height[left:right+1])>1 and left<=right:
            while left<right and height[left]<=height[left+1]:
                left += 1
            while right>left and height[right]<= height[right-1]:
                right -=1
            if (len(height[left:right+1])>0):
                fill_til = min(height[left], height[right])
                for i in range(left, right+1):
                    if height[i] < fill_til:
                        water_level += fill_til - height[i]
                        height[i] = fill_til
        return water_level

------


73. Set Matrix Zeroes
Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in-place.

Example 1:

Input: 
[
  [1,1,1],
  [1,0,1],
  [1,1,1]
]
Output: 
[
  [1,0,1],
  [0,0,0],
  [1,0,1]
]
Example 2:

Input: 
[
  [0,1,2,0],
  [3,4,5,2],
  [1,3,1,5]
]
Output: 
[
  [0,0,0,0],
  [0,4,5,0],
  [0,3,1,0]
]
Follow up:

A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?

class Solution(object):
    def setZeroes(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: void Do not return anything, modify matrix in-place instead.
        """
        rows = {}
        columns = {}
        if len(matrix)==0:
            return matrix
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if matrix[i][j]==0:
                    rows['%s'%i] = 1
                    columns['%s'%j] = 1
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if '%s'%i in rows.keys():
                    matrix[int(i)][int(j)] = 0
                if '%s'%j in columns.keys():
                    matrix[int(i)][int(j)] = 0
            
        
-----------

73. Set Matrix Zeroes.
Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in-place.

Example 1:

Input: 
[
  [1,1,1],
  [1,0,1],
  [1,1,1]
]
Output: 
[
  [1,0,1],
  [0,0,0],
  [1,0,1]
]
Example 2:

Input: 
[
  [0,1,2,0],
  [3,4,5,2],
  [1,3,1,5]
]
Output: 
[
  [0,0,0,0],
  [0,4,5,0],
  [0,3,1,0]
]
Follow up:

A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?

class Solution(object):
    def setZeroes(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: void Do not return anything, modify matrix in-place instead.
        """
        rows = {}
        columns = {}
        if len(matrix)==0:
            return matrix
        first_row = True
        first_column = True
        i = 0
        for j in range(0, len(matrix[0])):
            if matrix[i][j]==0:
                first_row = False
        j = 0
        for i in range(0, len(matrix)):
            if matrix[i][j]==0:
                first_column = False
        for i in range(1, len(matrix)):
            for j in range(1, len(matrix[0])):
                if matrix[i][j]==0:
                    matrix[0][j] = 0
                    matrix[i][0] = 0
        for i in range(1, len(matrix)):
            for j in range(1, len(matrix[0])):
                if matrix[0][j]==0:
                    matrix[i][j] = 0
                if matrix[i][0]==0:
                    matrix[i][j] = 0
        i = 0
        for j in range(0, len(matrix[0])):
            if first_row==False:
                matrix[i][j] =0
        j = 0
        for i in range(0, len(matrix)):
            if first_column == False:
                matrix[i][j] =0
            
------------

48. Rotate Image.
You are given an n x n 2D matrix representing an image.

Rotate the image by 90 degrees (clockwise).

Note:

You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

Example 1:

Given input matrix = 
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

rotate the input matrix in-place such that it becomes:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]
Example 2:

Given input matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
], 

rotate the input matrix in-place such that it becomes:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]
class Solution(object):
    def rotate(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: void Do not return anything, modify matrix in-place instead.
        """
        matrix_row_start = 0
        matrix_col_start = 0
        matrix_row = len(matrix)
        matrix_col = len(matrix[0])
        if matrix_row==1:
            return 
        up_ptr = [matrix_row_start,matrix_col_start]
        right_ptr = [matrix_row_start, matrix_col - 1]
        down_ptr = [matrix_row -1, matrix_col - 1]
        left_ptr = [matrix_row -1, matrix_col_start]
        while matrix_row - matrix_row_start > 1 and matrix_col - matrix_col_start > 1:
            while up_ptr[1]< matrix_col -1:
                matrix[up_ptr[0]][up_ptr[1]], matrix[right_ptr[0]][right_ptr[1]], matrix[down_ptr[0]][down_ptr[1]], \
                matrix[left_ptr[0]][left_ptr[1]] = matrix[left_ptr[0]][left_ptr[1]], matrix[up_ptr[0]][up_ptr[1]], \
                 matrix[right_ptr[0]][right_ptr[1]], matrix[down_ptr[0]][down_ptr[1]]
                up_ptr[1] += 1
                right_ptr[0] +=1
                down_ptr[1] -=1
                left_ptr[0] -=1
            matrix_row_start += 1
            matrix_col_start += 1
            matrix_row -= 1
            matrix_col -= 1
            up_ptr = [matrix_row_start,matrix_col_start]
            right_ptr = [matrix_row_start, matrix_col - 1]
            down_ptr = [matrix_row -1, matrix_col - 1]
            left_ptr = [matrix_row -1, matrix_col_start]

----------

54. Spiral Matrix.
Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.

Example 1:

Input:
[
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]
Output: [1,2,3,6,9,8,7,4,5]
Example 2:

Input:
[
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9,10,11,12]
]
Output: [1,2,3,4,8,12,11,10,9,5,6,7]

class Solution(object):
    def spiralOrder(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: List[int]
        """
        row_start = 0
        row_end = len(matrix)
        if row_end - row_start ==0:
            return matrix
        column_start = 0
        column_end = len(matrix[0])
        output = []
        if column_end - column_start ==0 and row_end - row_start ==0:
            return matrix
        cur = [column_start, row_start]
        while column_end - column_start >0 and row_end - row_start >0:
            if column_end - column_start ==1 and row_end - row_start ==1:
                output.append(matrix[cur[0]][cur[1]])
            while cur[1]<column_end-1:
                output.append(matrix[cur[0]][cur[1]])
                cur[1]+=1
            while cur[0]<row_end-1:
                output.append(matrix[cur[0]][cur[1]])
                cur[0]+=1
            while cur[1]>column_start:
                output.append(matrix[cur[0]][cur[1]])
                if row_end - row_start ==1:
                    return output
                cur[1]-=1
            while cur[0]>row_start:
                output.append(matrix[cur[0]][cur[1]])
                if column_end - column_start ==1:
                    return output
                cur[0]-=1
            column_start +=1
            column_end -=1
            row_start +=1
            row_end -=1
            cur = [column_start, row_start]
        return output
---------

206. Reverse Linked List.
Reverse a singly linked list.

Example:

Input: 1->2->3->4->5->NULL
Output: 5->4->3->2->1->NULL
Follow up:

A linked list can be reversed either iteratively or recursively. Could you implement both?.

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def reverseList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        if head is None:
            return head
        cur = head
        nxt = head.next
        if nxt is None:
            return head
        cur.next, nxt.next, cont = None, cur, nxt.next
        cur , nxt = nxt, cont
        while nxt is not None:
            nxt.next, cont =  cur, nxt.next
            cur , nxt = nxt, cont
        return cur

----------


141. Linked List Cycle.
Given a linked list, determine if it has a cycle in it.

To represent a cycle in the given linked list, we use an integer pos which represents the position (0-indexed) in the linked list where tail connects to. If pos is -1, then there is no cycle in the linked list.

 

Example 1:

Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where tail connects to the second node.


Example 2:

Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where tail connects to the first node.


Example 3:

Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.


 

Follow up:

Can you solve it using O(1) (i.e. constant) memory?


# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def hasCycle(self, head):
        """
        :type head: ListNode
        :rtype: bool
        """
        slow = head
        if head is None or head.next is None:
            return False
        fast = head.next.next
        while slow is not None and fast is not None and fast.next is not None:
            slow = slow.next
            fast = fast.next.next
            if slow==fast:
                return True
        return False

------------

2. Add Two Numbers.

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example:

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
Explanation: 342 + 465 = 807.
Accepted
744,263
Submissions
2,447,776
Seen this question in a real interview before?


# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        if l1 is None or (l1.next is None and l1.val==0):
            return l2
        if l2 is None or (l2.next is None and l2.val==0):
            return l1
        l1_ptr = l1
        l2_ptr = l2
        carry_over = 0
        result = ListNode(0)
        result_ptr = result
        result_ptr.val = (carry_over + l1_ptr.val + l2_ptr.val) % 10
        carry_over = (carry_over + l1_ptr.val + l2_ptr.val) //10
        while l1_ptr.next is not None and l2_ptr.next is not None:
            l1_ptr = l1_ptr.next
            l2_ptr = l2_ptr.next
            result_ptr.next = ListNode(0)
            result_ptr = result_ptr.next
            result_ptr.val = (carry_over + l1_ptr.val + l2_ptr.val) % 10
            carry_over = (carry_over + l1_ptr.val + l2_ptr.val) //10
        if l1_ptr.next is not None and l2_ptr.next is None:
            result_ptr.next = l1_ptr.next
        if l1_ptr.next is None and l2_ptr.next is not None:
            result_ptr.next = l2_ptr.next
        while carry_over>0:
            if result_ptr.next is None:
                result_ptr.next = ListNode(0)
            result_ptr = result_ptr.next
            carry_over, result_ptr.val = (result_ptr.val + carry_over)//10, (result_ptr.val + carry_over)%10
        return result
            
-------

445. Add Two Numbers II.
You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Follow up:
What if you cannot modify the input lists? In other words, reversing the lists is not allowed.

Example:

Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 8 -> 0 -> 7


# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        ln1 = 1
        l1_it = l1
        ln2 = 1
        l2_it = l2
        while l1_it.next is not None:
            l1_it = l1_it.next
            ln1 +=1
        while l2_it.next is not None:
            l2_it = l2_it.next
            ln2 +=1
        l1_it = l1
        l2_it = l2
        result = ListNode(0)
        result_it = result
        if ln1>ln2:
            while ln1!=ln2:
                result_it.next = ListNode(l1_it.val)
                result_it = result_it.next
                l1_it = l1_it.next
                ln1 -= 1
        elif ln1<ln2:
            while ln1!=ln2:
                result_it.next = ListNode(l2_it.val)
                result_it = result_it.next
                l2_it = l2_it.next
                ln2 -=1
        else:
            pass
        while l1_it is not None:
            result_it.next = ListNode(l1_it.val + l2_it.val)
            result_it = result_it.next
            l1_it = l1_it.next
            l2_it = l2_it.next
        change_sw = True
        while change_sw==True:
            result_it = result
            change_sw = False
            while result_it is not None:
                if result_it.next is not None and result_it.next.val>=10:
                    result_it.val += result_it.next.val//10
                    result_it.next.val %= 10
                    change_sw = True
                result_it = result_it.next
        if result.val == 0 and result.next is not None:
            return result.next
        else:
            return result
------

21. Merge Two Sorted Lists.

Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

Example:

Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def mergeTwoLists(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        if l1 is None:
            return l2
        if l2 is None:
            return l1
        l1_it = l1
        l2_it = l2
        result = ListNode(0)
        result_it = result
        while l1_it is not None and l2_it is not None:
            if l1_it.val<l2_it.val:
                result_it.next = ListNode(l1_it.val)
                l1_it = l1_it.next
                result_it = result_it.next
            else:
                result_it.next = ListNode(l2_it.val)
                l2_it = l2_it.next
                result_it = result_it.next
        if l1_it is not None:
            result_it.next = l1_it
        if l2_it is not None:
            result_it.next = l2_it
        return result.next

---------

23. Merge k Sorted Lists.
Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

Example:

Input:
[
  1->4->5,
  1->3->4,
  2->6
]
Output: 1->1->2->3->4->4->5->6


# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def mergeKLists(self, lists):
        """
        :type lists: List[ListNode]
        :rtype: ListNode
        """
        from heapq import *
        heap_list = []
        result = ListNode(0)
        result_it = result
        for i in range(len(lists)):
            if lists[i] is not None:
                heappush(heap_list,(lists[i].val,i ))
                lists[i] = lists[i].next
        while len(heap_list)>0:
            cur_min = heappop(heap_list)
            result_it.next = ListNode(cur_min[0])
            result_it = result_it.next
            i = cur_min[1]
            if lists[i] is not None:
                heappush(heap_list,(lists[i].val, i))
                lists[i] = lists[i].next
        return result.next

-----------

160. Intersection of Two Linked Lists.
Write a program to find the node at which the intersection of two singly linked lists begins.

For example, the following two linked lists:


begin to intersect at node c1.

 

Example 1:


Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
Output: Reference of the node with value = 8
Input Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,0,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.
 

Example 2:


Input: intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
Output: Reference of the node with value = 2
Input Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [0,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.
 

Example 3:


Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
Output: null
Input Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
Explanation: The two lists do not intersect, so return null.
 

Notes:

If the two linked lists have no intersection at all, return null.
The linked lists must retain their original structure after the function returns.
You may assume there are no cycles anywhere in the entire linked structure.
Your code should preferably run in O(n) time and use only O(1) memory.

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def getIntersectionNode(self, headA, headB):
        """
        :type head1, head1: ListNode
        :rtype: ListNode
        """
        if headA is None or headB is None:
            return None
        a_it = headA
        b_it = headB
        ln_a = 1
        ln_b = 1
        while a_it is not None:
            a_it = a_it.next
            ln_a += 1
        while b_it is not None:
            b_it = b_it.next
            ln_b +=1
        a_it = headA
        b_it = headB
        if ln_a>ln_b:
            for i in range(ln_a - ln_b):
                a_it = a_it.next
        else:
            for i in range(ln_b - ln_a):
                b_it = b_it.next
        while a_it != b_it and a_it is not None and b_it is not None:
            a_it = a_it.next
            b_it = b_it.next
        if a_it==b_it:
            return a_it
        else:
            return None
---------

138. Copy List with Random Pointer.
A linked list is given such that each node contains an additional random pointer which could point to any node in the list or null.

Return a deep copy of the list.

# Definition for singly-linked list with a random pointer.
# class RandomListNode(object):
#     def __init__(self, x):
#         self.label = x
#         self.next = None
#         self.random = None

class Solution(object):
    def copyRandomList(self, head):
        """
        :type head: RandomListNode
        :rtype: RandomListNode
        """
        if head is None:
            return None
        result = RandomListNode(0)
        h_it = head
        r_it = result
        node_hash = {}
        while h_it is not None:
            r_it.next = RandomListNode(h_it.label)
            try:
                node_hash[h_it] = r_it.next
            except:
                node_hash[h_it] = None
            r_it = r_it.next
            h_it = h_it.next
        r_it = result.next
        h_it = head
        while h_it is not None:
            try:
                r_it.random = node_hash[h_it.random]
            except:
                r_it.random = None
            r_it = r_it.next
            h_it = h_it.next
        return result.next
        
-------
98. Validate Binary Search Tree.
Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.
Example 1:

Input:
    2
   / \
  1   3
Output: true
Example 2:

    5
   / \
  1   4
     / \
    3   6
Output: false
Explanation: The input is: [5,1,4,null,null,3,6]. The root node's value
             is 5 but its right child's value is 4.

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def isValidBST(self, root):
        """
        :type root: TreeNode
        :rtype: bool
        """
        stack = list()
        cur_it = root
        if root is None:
            return True
        stack.append([root, False])
        max_so_far = -1e10
        while len(stack)>0:
            if stack[-1][1]== False:
                stack[-1][1] = True
                if stack[-1][0].left is not None:
                    stack.append([stack[-1][0].left,False])
                else:
                    if stack[-1][0].val <= max_so_far:
                        return False
                    else:
                        max_so_far = stack[-1][0].val
                    cur_node = stack[-1][0]
                    del stack[-1]
                    if cur_node.right is not None:
                        stack.append([cur_node.right, False])
            else: # time to traverse right
                if stack[-1][0].val <= max_so_far:
                    return False
                else:
                    max_so_far = stack[-1][0].val
                cur_node = stack[-1][0]
                del stack[-1]
                if cur_node.right is not None:
                    stack.append([cur_node.right, False])
        return True
-------


98. Validate Binary Search Tree.
Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.
Example 1:

Input:
    2
   / \
  1   3
Output: true
Example 2:

    5
   / \
  1   4
     / \
    3   6
Output: false
Explanation: The input is: [5,1,4,null,null,3,6]. The root node's value
             is 5 but its right child's value is 4.

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def isValidBST(self, root):
        """
        :type root: TreeNode
        :rtype: bool
        """
        stack = list()
        cur_it = root
        if root is None:
            return True
        stack.append([root, False])
        max_so_far = -1e10
        while len(stack)>0:
            if stack[-1][1]== False:
                stack[-1][1] = True
                if stack[-1][0].left is not None:
                    stack.append([stack[-1][0].left,False])
                else:
                    if stack[-1][0].val <= max_so_far:
                        return False
                    else:
                        max_so_far = stack[-1][0].val
                    cur_node = stack[-1][0]
                    stack.pop()
                    if cur_node.right is not None:
                        stack.append([cur_node.right, False])
            else: # time to traverse right
                if stack[-1][0].val <= max_so_far:
                    return False
                else:
                    max_so_far = stack[-1][0].val
                cur_node = stack[-1][0]
                stack.pop()
                if cur_node.right is not None:
                    stack.append([cur_node.right, False])
        return True
-------


94. Binary Tree Inorder Traversal.
Given a binary tree, return the inorder traversal of its nodes' values.

Example:

Input: [1,null,2,3]
   1
    \
     2
    /
   3

Output: [1,3,2]
Follow up: Recursive solution is trivial, could you do it iteratively?

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def inorderTraversal(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        if root is None:
            return []
        stack = list()
        stack.append([root, False])
        result = list()
        while len(stack)>0:
            if stack[-1][1]==False:
                stack[-1][1] = True
                if stack[-1][0].left is not None:
                    stack.append([stack[-1][0].left, False])
            else: # means the left has already been traversed
                result.append(stack[-1][0].val)
                cur_root = stack.pop()
                if cur_root[0].right is not None:
                    stack.append([cur_root[0].right, False])
        return result

---------
102. Binary Tree Level Order Traversal.

Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its level order traversal as:
[
  [3],
  [9,20],
  [15,7]
]

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def levelOrder(self, root):
        """
        :type root: TreeNode
        :rtype: List[List[int]]
        """
        from collections import deque
        queue = deque(list())
        result = list()
        intermediary_result = list()
        if root is None:
            return []
        level = 0
        queue.append([root, level])
        while len(queue)>0:
            intermediary_result = list()
            while len(queue)>0 and queue[0][1]==level:
                cur_root = queue.popleft()[0]
                intermediary_result.append(cur_root.val)
                if cur_root.left is not None:
                    queue.append([cur_root.left, level+1])
                if cur_root.right is not None:
                    queue.append([cur_root.right, level+1])
            level += 1 
            result.append(intermediary_result)
        return result
------

103. Binary Tree Zigzag Level Order Traversal.
Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its zigzag level order traversal as:
[
  [3],
  [20,9],
  [15,7]
]

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def zigzagLevelOrder(self, root):
        """
        :type root: TreeNode
        :rtype: List[List[int]]
        """
        from collections import deque
        ltr = True
        ltr_stack = list()
        rtl_stack = list()
        result = list()
        intermediary_result = list()
        if root is None:
            return []
        ltr_stack.append(root)
        while (ltr is True and len(ltr_stack)>0) or (ltr is False and len(rtl_stack)>0):
            if ltr is True:
                rtl_stack = list()
                intermediary_result = list()
                while len(ltr_stack)>0:
                    cur_node = ltr_stack.pop()
                    if cur_node.left is not None:
                        rtl_stack.append(cur_node.left)
                    if cur_node.right is not None:
                        rtl_stack.append(cur_node.right)
                    intermediary_result.append(cur_node.val)
                result.append(intermediary_result)
                ltr = False
            else: # we are in rtl mode
                ltr_stack = list()
                intermediary_result = list()
                while len(rtl_stack)>0:
                    cur_node = rtl_stack.pop()
                    if cur_node.right is not None:
                        ltr_stack.append(cur_node.right)
                    if cur_node.left is not None:
                        ltr_stack.append(cur_node.left)
                    intermediary_result.append(cur_node.val)
                result.append(intermediary_result)
                ltr = True
        return result

------------

116. Populating Next Right Pointers in Each Node.
Given a binary tree

struct TreeLinkNode {
  TreeLinkNode *left;
  TreeLinkNode *right;
  TreeLinkNode *next;
}
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

Initially, all next pointers are set to NULL.

Note:

You may only use constant extra space.
Recursive approach is fine, implicit stack space does not count as extra space for this problem.
You may assume that it is a perfect binary tree (ie, all leaves are at the same level, and every parent has two children).
Example:

Given the following perfect binary tree,

     1
   /  \
  2    3
 / \  / \
4  5  6  7
After calling your function, the tree should look like:

     1 -> NULL
   /  \
  2 -> 3 -> NULL
 / \  / \
4->5->6->7 -> NULL


# Definition for binary tree with next pointer.
# class TreeLinkNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
#         self.next = None

class Solution:
    # @param root, a tree link node
    # @return nothing
    def connect(self, root):
        if root is None:
            return 
        self.connect_to_next(root)
        return 
    def connect_to_next(self, node):
        if node is None:
            return node
        if node.left is not None:
            node.left.next = node.right
        if node.right is not None and node.next is not None:
            node.right.next = node.next.left
        if node.right is not None:
            self.connect_to_next(node.right)
        if node.left is not None:
            self.connect_to_next(node.left)
        return node
------


117. Populating Next Right Pointers in Each Node II.

Given a binary tree

struct TreeLinkNode {
  TreeLinkNode *left;
  TreeLinkNode *right;
  TreeLinkNode *next;
}
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

Initially, all next pointers are set to NULL.

Note:

You may only use constant extra space.
Recursive approach is fine, implicit stack space does not count as extra space for this problem.
Example:

Given the following binary tree,

     1
   /  \
  2    3
 / \    \
4   5    7
After calling your function, the tree should look like:

     1 -> NULL
   /  \
  2 -> 3 -> NULL
 / \    \
4-> 5 -> 7 -> NULL

# Definition for binary tree with next pointer.
# class TreeLinkNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
#         self.next = None

class Solution:
    # @param root, a tree link node
    # @return nothing
    def connect(self, root):
        if root is None:
            return
        self.connect_to_right(root)
        return
    def connect_to_right(self, node):
        if node.left is not None:
            if node.right is not None:
                node.left.next = node.right
            else:
                connected = False
                cur_node = node.next
                while cur_node is not None and connected is False:
                    if cur_node.left is not None:
                        node.left.next = cur_node.left
                        connected = True
                    elif cur_node.right is not None:
                        node.left.next = cur_node.right
                        connected = True
                    else:
                        cur_node = cur_node.next
        if node.right is not None:
            connected = False
            cur_node = node.next
            while cur_node is not None and connected is False:
                if cur_node.left is not None:
                    node.right.next = cur_node.left
                    connected = True
                elif cur_node.right is not None:
                    node.right.next = cur_node.right
                    connected = True
                else:
                    cur_node = cur_node.next 
        if node.right is not None:
            self.connect_to_right(node.right)
        if node.left is not None:
            self.connect_to_right(node.left)
        return 

---------

235. Lowest Common Ancestor of a Binary .

Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

Given binary search tree:  root = [6,2,8,0,4,7,9,null,null,3,5]


 

Example 1:

Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
Explanation: The LCA of nodes 2 and 8 is 6.
Example 2:

Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
Output: 2
Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
 

Note:

All of the nodes' values will be unique.
p and q are different and both values will exist in the BST.


# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def lowestCommonAncestor(self, root, p, q):
        """
        :type root: TreeNode
        :type p: TreeNode
        :type q: TreeNode
        :rtype: TreeNode
        """
        root_ptr = root
        p_list = list()
        while root_ptr!=p:
            p_list.append(root_ptr)
            if root_ptr.val<p.val:
                root_ptr = root_ptr.right
            else: #>
                root_ptr = root_ptr.left
        p_list.append(root_ptr)
        root_ptr = root
        q_list = list()
        while root_ptr!=q:
            q_list.append(root_ptr)
            if root_ptr.val<q.val:
                root_ptr = root_ptr.right
            else: #>
                root_ptr = root_ptr.left
        q_list.append(root_ptr)
        list_ptr = min(len(p_list), len(q_list)) - 1
        while list_ptr!=0:
            if p_list[list_ptr]== q_list[list_ptr]:
                return p_list[list_ptr]
            else:
                list_ptr -=1
        return p_list[list_ptr]
        

-------


236. Lowest Common Ancestor of a Binary Tree.

Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

Given the following binary tree:  root = [3,5,1,6,2,0,8,null,null,7,4]


 

Example 1:

Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
Output: 3
Explanation: The LCA of nodes 5 and 1 is 3.
Example 2:

Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
Output: 5
Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
 

Note:

All of the nodes' values will be unique.
p and q are different and both values will exist in the binary tree.


# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def lowestCommonAncestor(self, root, p, q):
        """
        :type root: TreeNode
        :type p: TreeNode
        :type q: TreeNode
        :rtype: TreeNode
        """
        if root is None:
            return None
        parent_map = dict()
        traversal_stack = list()
        traversal_stack.append(root)
        while len(traversal_stack)>0:
            cur_node = traversal_stack.pop()
            if cur_node.left is not None:
                parent_map[cur_node.left] = cur_node
                traversal_stack.append(cur_node.left)
            if cur_node.right is not None:
                parent_map[cur_node.right] = cur_node
                traversal_stack.append(cur_node.right)
        p_path = list()
        q_path = list()
        cur_p = p
        cur_q = q
        while cur_p!=root:
            try:
                p_path.append(cur_p)
                cur_p = parent_map[cur_p]
            except:
                return None
        p_path.append(root)
        while cur_q!=root:
            try:
                q_path.append(cur_q)
                cur_q = parent_map[cur_q]
            except:
                return None
        q_path.append(root)
        end_p = len(p_path)-1
        end_q = len(q_path)-1
        while end_p>=0 and end_q>=0 and p_path[end_p]==q_path[end_q]:
            end_p -= 1
            end_q -=1
        if end_p<0:
            return p_path[0]
        if end_q<0:
            return q_path[0]
        return p_path[end_p + 1]
--------
283. Move Zeroes.

Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

Example:

Input: [0,1,0,3,12]
Output: [1,3,12,0,0]
Note:

You must do this in-place without making a copy of the array.
Minimize the total number of operations.

class Solution(object):
    def moveZeroes(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        cur_ptr = 0
        offset = 0
        while cur_ptr<len(nums):
            if nums[cur_ptr] == 0:
                offset -=1
            elif offset<0:
                nums[cur_ptr+offset] = nums[cur_ptr]
            else:
                pass
            cur_ptr+=1
        while offset<0:
            nums[offset] = 0
            offset += 1

---------


67. Add Binary.

Given two binary strings, return their sum (also a binary string).

The input strings are both non-empty and contains only characters 1 or 0.

Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"

class Solution(object):
    def addBinary(self, a, b):
        """
        :type a: str
        :type b: str
        :rtype: str
        """
        a_ptr = len(a)-1
        b_ptr = len(b)-1
        result = ''
        offset = 0
        while a_ptr>=0 or b_ptr>=0:
            if a_ptr >=0:
                first = a[a_ptr]
            else:
                first = '0'
            if b_ptr>=0:
                second = b[b_ptr]
            else:
                second = '0'
            if first=='1' and second=='1' and offset==1:
                result = '1'+ result
                offset = 1
            elif first=='1' and second=='1' and offset==0:
                result ='0'+ result
                offset = 1
            elif  first=='1' and second=='0' and offset==1:
                result ='0'+ result
                offset = 1
            elif  first=='0' and second=='1' and offset==1:
                result =  '0'+ result
                offset = 1
            elif  first=='1' and second=='0' and offset==0:
                result = '1'+ result
                offset = 0
            elif  first=='0' and second=='1' and offset==0:
                result =  '1' + result
                offset = 0
            elif  first=='0' and second=='0' and offset==1:
                result =  '1' + result
                offset = 0
            else:
                result =  '0'+ result
                offset = 0
            a_ptr -=1
            b_ptr -=1
        if offset==1:
            result = '1' + result
        return result

------


176. Second Highest Salary.

Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+


/* Write your T-SQL query statement below */
select case when min(salary)=min(max_salary) then null else min(salary) end as  SecondHighestSalary 
from 
(select top(2) 1 as indx, salary
from Employee
group by salary
order by salary desc) as top_two join
(select 1 as indx, max(salary) as max_salary
from Employee) as top_one on top_two.indx = top_one.indx

-------


176. Second Highest Salary.

Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

/* Write your T-SQL query statement below */
SELECT MAX(salary) as SecondHighestSalary  FROM Employee WHERE Salary NOT IN ( SELECT Max(Salary) FROM Employee)


----------

176. Second Highest Salary.

Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

/* Write your T-SQL query statement below */
select max(salary) as SecondHighestSalary 
from Employee
where salary not in (select max(salary) from Employee)

--------

177. Nth Highest Salary.

Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        /* Write your T-SQL query statement below. */
        select salary from 
        (select salary, row_number() over(order by salary desc) as row_number
        from (select salary from Employee group by salary) as t1) as t2
        where row_number=@N
    );
END

-------

183. Customers Who Never Order.

Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+


/* Write your T-SQL query statement below */
select Name as Customers
from
(select Id as customerId, Name from Customers) as cust_t 
left outer join
(select customerId from Orders) as ord_t
on cust_t.customerId = ord_t.customerId
where ord_t.customerId is null

--------

602. Friend Requests II: Who Has the Most Friends.

In social network like Facebook or Twitter, people send friend requests and accept others' requests as well.
Table request_accepted holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.
| requester_id | accepter_id | accept_date|
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
Write a query to find the the people who has most friends and the most friends number. For the sample data above, the result is:
| id | num |
|----|-----|
| 3  | 3   |
Note:
It is guaranteed there is only 1 people having the most friends.
The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
Explanation:
The person with id '3' is a friend of people '1', '2' and '4', so he has 3 friends in total, which is the most number than any others.
Follow-up:
In the real world, multiple people could have the same most number of friends, can you find all these people in this case?

# Write your MySQL query statement below

select id, count_friend as num
from (select id, count(*) as count_friend
from (select  requester_id as id
from request_accepted
union all select accepter_id as id
from request_accepted) as t1
group by id) as t3
where count_friend in 
(select max(count_friend)
from 
(select id, count(*) as count_friend
from (select  requester_id as id
from request_accepted
union all select accepter_id as id
from request_accepted) as t1
group by id) as t2)



-------
185. Department Top Three Salaries.

The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows.

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+


/* Write your T-SQL query statement below */

select Department.Name as Department, t2.Name as Employee, Salary
from Employee as T2
join Department on t2.DepartmentId = Department.Id
where (select count(distinct(salary)) from Employee
      where Employee.DepartmentId = T2.DepartmentId and Employee.Salary>T2.Salary)<3


-------

175. Combine Two Tables.

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| PersonId    | int     |
| FirstName   | varchar |
| LastName    | varchar |
+-------------+---------+
PersonId is the primary key column for this table.
Table: Address

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
AddressId is the primary key column for this table.
 

Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:

FirstName, LastName, City, State

/* Write your T-SQL query statement below */
select FirstName, LastName, City, State
from Person left join
Address on Person.PersonId = Address.PersonId

--------

595. Big Countries.

There is a table World

+-----------------+------------+------------+--------------+---------------+
| name            | continent  | area       | population   | gdp           |
+-----------------+------------+------------+--------------+---------------+
| Afghanistan     | Asia       | 652230     | 25500100     | 20343000      |
| Albania         | Europe     | 28748      | 2831741      | 12960000      |
| Algeria         | Africa     | 2381741    | 37100000     | 188681000     |
| Andorra         | Europe     | 468        | 78115        | 3712000       |
| Angola          | Africa     | 1246700    | 20609294     | 100990000     |
+-----------------+------------+------------+--------------+---------------+
A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.

Write a SQL solution to output big countries' name, population and area.

For example, according to the above table, we should output:

+--------------+-------------+--------------+
| name         | population  | area         |
+--------------+-------------+--------------+
| Afghanistan  | 25500100    | 652230       |
| Algeria      | 37100000    | 2381741      |
+--------------+-------------+--------------+

# Write your MySQL query statement below
select name, population, area
from World
where population>25000000 or area>3000000

---------

178. Rank Scores.

Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. Note that after a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no "holes" between ranks.

+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
For example, given the above Scores table, your query should generate the following report (order by highest score):

+-------+------+
| Score | Rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+

/* Write your T-SQL query statement below */
select t2.Score, Rank
from (select t1.Score, row_number() over(order by t1.Score desc) as Rank
from (select distinct Score  
from Scores) as t1) as t3
join Scores as t2 on t3.Score = t2.Score
order by Rank asc
 

-------------

627. Swap Salary.

Given a table salary, such as the one below, that has m=male and f=female values. Swap all f and m values (i.e., change all f values to m and vice versa) with a single update query and no intermediate temp table.
For example:
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
After running your query, the above salary table should have the following rows:
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |


# Write your MySQL query statement below
update salary
set sex=case when sex='f' then 'm' else 'f' end;


----------


181. Employees Earning More Than Their Managers.

The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+

/* Write your T-SQL query statement below */
Select Name as Employee
from 
(Select emp.Name, emp.Salary, mt.salary as MTSal
from Employee emp 
 join Employee as mt 
 on emp.ManagerId=mt.Id) as t1
 where t1.Salary > t1.MTSal

--------
196. Delete Duplicate Emails.

Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Note:

Your output is the whole Person table after executing your sql. Use delete statement.

# Write your MySQL query statement below
delete p1 from Person p1, Person p2
where p1.Email = p2.Email and p1.Id>p2.Id

-----

196. Delete Duplicate Emails.

# Write your MySQL query statement below
delete p from Person as p
where p.Id not in 
(select Id from (select min(Person.Id) as Id from Person group by Person.Email) as ToRemovedId);

------

196. Delete Duplicate Emails.

Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Note:

Your output is the whole Person table after executing your sql. Use delete statement.

# Write your MySQL query statement below
delete p1 from Person as P1, Person as P2
where P1.Email = P2.Email and P1.Id>P2.Id

------

180. Consecutive Numbers.

Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

/* Write your T-SQL query statement below */
select distinct L1.Num as ConsecutiveNums
from Logs L1 
join Logs L2 on L1.id+1 = L2.id and L1.Num=L2.Num
join Logs L3 on L1.id+2 = L3.id and L1.Num = L3.Num

--------

184. Department Highest Salary.

The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, Max has the highest salary in the IT department and Henry has the highest salary in the Sales department.

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+

/* Write your T-SQL query statement below */
select Department.Name as Department, emp.Name as Employee, Salary
from 
Employee as emp join 
(select DepartmentId, max(Salary) as maxSalary
from Employee
group by DepartmentId) as maxST 
on emp.DepartmentId = maxST.DepartmentId
join Department 
on emp.DepartmentId = Department.Id
where Salary=maxSalary
 

-------------

182. Duplicate Emails.

Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Note: All emails are in lowercase.

/* Write your T-SQL query statement below */

select Email 
from
(select Email, count(*) as num
from Person
group by Email
) as t
where num>1

-------


612. Shortest Distance in a Plane.

Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
Write a query to find the shortest distance between these points rounded to 2 decimals.
| x  | y  |
|----|----|
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |
The shortest distance is 1.00 from point (-1,-1) to (-1,2). So the output should be:
| shortest |
|----------|
| 1.00     |
Note: The longest distance among all the points are less than 10000.

# Write your MySQL query statement below
select round(min(distance),2) as shortest from
(select sqrt((p1.x - p2.x)*(p1.x - p2.x)+ (p1.y - p2.y)*(p1.y - p2.y)) as distance
from point_2d as p1
join point_2d as p2 on not (p1.x=p2.x and p1.y=p2.y)) as d

-------------

620. Not Boring Movies.

X city opened a new cinema, many people would like to go to this cinema. The cinema also gives out a poster indicating the movies’ ratings and descriptions.
Please write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. Order the result by rating.

For example, table cinema:

+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War       |   great 3D   |   8.9     |
|   2     | Science   |   fiction    |   8.5     |
|   3     | irish     |   boring     |   6.2     |
|   4     | Ice song  |   Fantacy    |   8.6     |
|   5     | House card|   Interesting|   9.1     |
+---------+-----------+--------------+-----------+
For the example above, the output should be:
+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   5     | House card|   Interesting|   9.1     |
|   1     | War       |   great 3D   |   8.9     |
+---------+-----------+--------------+-----------+


# Write your MySQL query statement below
select *
from cinema as m
where (not m.description='boring') and mod(m.id, 2)=1
order by m.rating desc

------------

577. Employee Bonus.

Select all employee's name and bonus whose bonus is < 1000.

Table:Employee

+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId is the primary key column for this table.
Table: Bonus

+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId is the primary key column for this table.
Example ouput:

+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+

# Write your MySQL query statement below
select e1.name, b1.bonus
from Employee e1 left join Bonus as b1 on e1.empId = b1.empId
where b1.bonus is null or b1.bonus<1000

----------

577. Employee Bonus.

Select all employee's name and bonus whose bonus is < 1000.

Table:Employee

+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId is the primary key column for this table.
Table: Bonus

+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId is the primary key column for this table.
Example ouput:

+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+

# Write your MySQL query statement below
select e1.name, b1.bonus
from Employee e1 left join Bonus as b1 on e1.empId = b1.empId
where e1.empId not in (select empId from Bonus as b2 where bonus>=1000)

--------

626. Exchange Seats.

Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

The column id is continuous increment.
Mary wants to change seats for the adjacent students.
Can you write a SQL query to output the result for Mary?
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note:
If the number of students is odd, there is no need to change the last one's seat.

# Write your MySQL query statement below
select id, student
from 
(select case when mod(s1.id, 2)=0 then s1.id-1 else s1.id+1 end as id, s1.student
from seat as s1
where id not in (select case when mod(max(s2.id),2)=1 then max(s2.id) else -1 end as id from seat as s2) 
union all
select s3.id, s3.student
from seat as s3
where s3.id in (select case when mod(max(s4.id),2)=1 then max(s4.id) else -1 end as id from seat as s4)) as s5
order by id

-----

574. Winning Candidate.

Table: Candidate

+-----+---------+
| id  | Name    |
+-----+---------+
| 1   | A       |
| 2   | B       |
| 3   | C       |
| 4   | D       |
| 5   | E       |
+-----+---------+  
Table: Vote

+-----+--------------+
| id  | CandidateId  |
+-----+--------------+
| 1   |     2        |
| 2   |     4        |
| 3   |     3        |
| 4   |     2        |
| 5   |     5        |
+-----+--------------+
id is the auto-increment primary key,
CandidateId is the id appeared in Candidate table.
Write a sql to find the name of the winning candidate, the above example will return the winner B.

+------+
| Name |
+------+
| B    |
+------+
Notes:
You may assume there is no tie, in other words there will be at most one winning candidate.

# Write your MySQL query statement below
SELECT Name FROM Candidate
WHERE id = (SELECT CandidateId FROM Vote GROUP BY CandidateId ORDER BY COUNT(*) DESC LIMIT 1);

-------

574. Winning Candidate.

Table: Candidate

+-----+---------+
| id  | Name    |
+-----+---------+
| 1   | A       |
| 2   | B       |
| 3   | C       |
| 4   | D       |
| 5   | E       |
+-----+---------+  
Table: Vote

+-----+--------------+
| id  | CandidateId  |
+-----+--------------+
| 1   |     2        |
| 2   |     4        |
| 3   |     3        |
| 4   |     2        |
| 5   |     5        |
+-----+--------------+
id is the auto-increment primary key,
CandidateId is the id appeared in Candidate table.
Write a sql to find the name of the winning candidate, the above example will return the winner B.

+------+
| Name |
+------+
| B    |
+------+
Notes:
You may assume there is no tie, in other words there will be at most one winning candidate.


# Write your MySQL query statement below
select Name 
from Candidate
where id in (
   select CandidateId from(
       select count(CandidateId) as cc, CandidateId
       from vote group by CandidateId
       order by cc desc limit 1)t
)

--------

574. Winning Candidate.

# Write your MySQL query statement below
select Name 
from Candidate
where id = (
   select CandidateId from(
       select count(CandidateId) as cc, CandidateId
       from vote group by CandidateId
       order by cc desc limit 1)t
)

------

586. Customer Placing the Largest Number of Orders.

Query the customer_number from the orders table for the customer who has placed the largest number of orders.

It is guaranteed that exactly one customer will have placed more orders than any other customer.

The orders table is defined as follows:

| Column            | Type      |
|-------------------|-----------|
| order_number (PK) | int       |
| customer_number   | int       |
| order_date        | date      |
| required_date     | date      |
| shipped_date      | date      |
| status            | char(15)  |
| comment           | char(200) |
Sample Input

| order_number | customer_number | order_date | required_date | shipped_date | status | comment |
|--------------|-----------------|------------|---------------|--------------|--------|---------|
| 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
| 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
| 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
| 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |
Sample Output

| customer_number |
|-----------------|
| 3               |
Explanation

The customer with number '3' has two orders, which is greater than either customer '1' or '2' because each of them  only has one order. 
So the result is customer_number '3'.
Follow up: What if more than one customer have the largest number of orders, can you find all the customer_number in this case?

# Write your MySQL query statement below
select customer_number
from orders 
group by customer_number
order by count(*) desc
limit 1

------

570. Managers with at Least 5 Direct Reports.

The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+------+----------+-----------+----------+
|Id    |Name 	  |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	  |A 	      |null      |
|102   |Dan 	  |A 	      |101       |
|103   |James 	  |A 	      |101       |
|104   |Amy 	  |A 	      |101       |
|105   |Anne 	  |A 	      |101       |
|106   |Ron 	  |B 	      |101       |
+------+----------+-----------+----------+
Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

+-------+
| Name  |
+-------+
| John  |
+-------+
Note:
No one would report to himself.

# Write your MySQL query statement below
select e2.Name
from Employee as e1 join Employee as e2 on e1.ManagerId = e2.Id
group by e1.ManagerId
having count(*)>=5

-----

613. Shortest Distance in a Line.

Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
Write a query to find the shortest distance between two points in these points.
| x   |
|-----|
| -1  |
| 0   |
| 2   |
The shortest distance is '1' obviously, which is from point '-1' to '0'. So the output is as below:
| shortest|
|---------|
| 1       |
Note: Every point is unique, which means there is no duplicates in table point.
Follow-up: What if all these points have an id and are arranged from the left most to the right most of x axis?

# Write your MySQL query statement below
select min(abs(t1.x - t2.x)) as shortest
from point as t1 join point as t2 on (not t1.x = t2.x)

------

584. Find Customer Referee.

Given a table customer holding customers information and the referee.

+------+------+-----------+
| id   | name | referee_id|
+------+------+-----------+
|    1 | Will |      NULL |
|    2 | Jane |      NULL |
|    3 | Alex |         2 |
|    4 | Bill |      NULL |
|    5 | Zack |         1 |
|    6 | Mark |         2 |
+------+------+-----------+
Write a query to return the list of customers NOT referred by the person with id '2'.

For the sample data above, the result is:

+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+

# Write your MySQL query statement below
select name
from customer
where (referee_id is null) or (not referee_id=2)

------

585. Investments in 2016.

Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places, for all policy holders who meet the following criteria:

Have the same TIV_2015 value as one or more other policyholders.
Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).
Input Format:
The insurance table is described as follows:

| Column Name | Type          |
|-------------|---------------|
| PID         | INTEGER(11)   |
| TIV_2015    | NUMERIC(15,2) |
| TIV_2016    | NUMERIC(15,2) |
| LAT         | NUMERIC(5,2)  |
| LON         | NUMERIC(5,2)  |
where PID is the policyholder's policy ID, TIV_2015 is the total investment value in 2015, TIV_2016 is the total investment value in 2016, LAT is the latitude of the policy holder's city, and LON is the longitude of the policy holder's city.

Sample Input

| PID | TIV_2015 | TIV_2016 | LAT | LON |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
Sample Output

| TIV_2016 |
|----------|
| 45.00    |
Explanation

The first record in the table, like the last record, meets both of the two criteria.
The TIV_2015 value '10' is as the same as the third and forth record, and its location unique.

The second record does not meet any of the two criteria. Its TIV_2015 is not like any other policyholders.

And its location is the same with the third record, which makes the third record fail, too.

So, the result is the sum of TIV_2016 of the first and last record, which is 45.

# Write your MySQL query statement below

select sum(TIV_2016) as TIV_2016
from insurance as i1
join
(select Lat, Lon
from insurance  as i2
group by Lat, Lon
having not count(*)>1) as ll on ll.Lat = i1.Lat and ll.Lon = i1.Lon
where i1.TIV_2015 in 
(select TIV_2015
from insurance as i3
group by TIV_2015
having count(*)>1)

-----

585. Investments in 2016.

Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places, for all policy holders who meet the following criteria:

Have the same TIV_2015 value as one or more other policyholders.
Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).
Input Format:
The insurance table is described as follows:

| Column Name | Type          |
|-------------|---------------|
| PID         | INTEGER(11)   |
| TIV_2015    | NUMERIC(15,2) |
| TIV_2016    | NUMERIC(15,2) |
| LAT         | NUMERIC(5,2)  |
| LON         | NUMERIC(5,2)  |
where PID is the policyholder's policy ID, TIV_2015 is the total investment value in 2015, TIV_2016 is the total investment value in 2016, LAT is the latitude of the policy holder's city, and LON is the longitude of the policy holder's city.

Sample Input

| PID | TIV_2015 | TIV_2016 | LAT | LON |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
Sample Output

| TIV_2016 |
|----------|
| 45.00    |
Explanation

The first record in the table, like the last record, meets both of the two criteria.
The TIV_2015 value '10' is as the same as the third and forth record, and its location unique.

The second record does not meet any of the two criteria. Its TIV_2015 is not like any other policyholders.

And its location is the same with the third record, which makes the third record fail, too.

So, the result is the sum of TIV_2016 of the first and last record, which is 45.

# Write your MySQL query statement below

select sum(TIV_2016) as TIV_2016
from insurance as i1
join
(select Lat, Lon
from insurance  as i2
group by Lat, Lon
having not count(*)>1) as ll on ll.Lat = i1.Lat and ll.Lon = i1.Lon
where i1.TIV_2015 in 
(select TIV_2015
from insurance as i3
group by TIV_2015
having count(*)>1)

-------

197. Rising Temperature.

Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
For example, return the following Ids for the above Weather table:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+

/* Write your T-SQL query statement below */
select w2.Id
from Weather as w1 join Weather as w2 
on (w1.Temperature< w2.Temperature) and (datediff(w2.RecordDate, w1.RecordDate) = 1)

----------

350. Intersection of Two Arrays II.

Given two arrays, write a function to compute their intersection.

Example 1:

Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2,2]
Example 2:

Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [4,9]
Note:

Each element in the result should appear as many times as it shows in both arrays.
The result can be in any order.
Follow up:

What if the given array is already sorted? How would you optimize your algorithm?
What if nums1's size is small compared to nums2's size? Which algorithm is better?
What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?

class Solution(object):
    def intersect(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        a1_dict = {}
        a2_dict = {}
        if len(nums1) == 0:
            return []
        if len(nums2) == 0:
            return []
        for num in range(len(nums1)):
            if nums1[num] in a1_dict.keys():
                a1_dict[nums1[num]] = a1_dict[nums1[num]] + 1
            else:
                a1_dict[nums1[num]] = 1
        for num in range(len(nums2)):
            if nums2[num] in a2_dict.keys():
                a2_dict[nums2[num]] = a2_dict[nums2[num]]  + 1
            else:
                a2_dict[nums2[num]] = 1
        output = []
        for item in a1_dict.keys():
            if item in a2_dict.keys():
                output = output + ([item]*min(a1_dict[item], a2_dict[item]))
        return output

--------------

596. Classes More Than 5 Students.

There is a table courses with columns: student and class

Please list out all classes which have more than or equal to 5 students.

For example, the table:

+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+
Should output:

+---------+
| class   |
+---------+
| Math    |
+---------+
Note:
The students should not be counted duplicate in each course.

# Write your MySQL query statement below
select class
from courses
group by class
having count(distinct student)>=5

-------

580. Count Student Number in Departments.

A university uses 2 data tables, student and department, to store data about its students and the departments associated with each major.

Write a query to print the respective department name and number of students majoring in each department for all departments in the department table (even ones with no current students).

Sort your results by descending number of students; if two or more departments have the same number of students, then sort those departments alphabetically by department name.

The student is described as follow:

| Column Name  | Type      |
|--------------|-----------|
| student_id   | Integer   |
| student_name | String    |
| gender       | Character |
| dept_id      | Integer   |
where student_id is the student's ID number, student_name is the student's name, gender is their gender, and dept_id is the department ID associated with their declared major.

And the department table is described as below:

| Column Name | Type    |
|-------------|---------|
| dept_id     | Integer |
| dept_name   | String  |
where dept_id is the department's ID number and dept_name is the department name.

Here is an example input:
student table:

| student_id | student_name | gender | dept_id |
|------------|--------------|--------|---------|
| 1          | Jack         | M      | 1       |
| 2          | Jane         | F      | 1       |
| 3          | Mark         | M      | 2       |
department table:

| dept_id | dept_name   |
|---------|-------------|
| 1       | Engineering |
| 2       | Science     |
| 3       | Law         |
The Output should be:

| dept_name   | student_number |
|-------------|----------------|
| Engineering | 2              |
| Science     | 1              |
| Law         | 0              |

# Write your MySQL query statement below
select dept_name, count(student_id) as student_number
from  department as d left join student as s on s.dept_id = d.dept_id
group by dept_name
order by count(student_id) desc, dept_name

---------

680. Valid Palindrome II.

Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.

Example 1:
Input: "aba"
Output: True
Example 2:
Input: "abca"
Output: True
Explanation: You could delete the character 'c'.
Note:
The string will only contain lowercase characters a-z. The maximum length of the string is 50000.

class Solution(object):
    def validPalindrome(self, s):
        """
        :type s: str
        :rtype: bool
        """
        error = 0
        start = 0
        end = len(s)-1
        while start<end:
            if s[start]!=s[end]:
                if error<1:
                    error +=1
                    if s[start+1] ==s[end] and s[end-1]!=s[start]:
                        start = start +1
                    elif s[end-1]==s[start] and s[start+1] !=s[end]:
                        end = end -1
                    elif  s[end-1]==s[start] and s[start+1] ==s[end]:
                        if len(s)>2 and s[end-2]==s[start+1] and s[end-1]==s[start+2]:
                            if len(s)>3 and s[end-3]==s[start+2]:
                                end = end -1
                            else:
                                start = start +1
                        elif  s[end-2]==s[start+1]:
                            end = end -1
                        else:
                            start = start + 1
                    else:
                        return False
                else:
                    return False
            start += 1
            end -=1
        return True
----------

125. Valid Palindrome.

Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Note: For the purpose of this problem, we define empty string as valid palindrome.

Example 1:

Input: "A man, a plan, a canal: Panama"
Output: true
Example 2:

Input: "race a car"
Output: false

class Solution(object):
    def isPalindrome(self, s):
        """
        :type s: str
        :rtype: bool
        """
        if len(s)<=1:
            return True
        # first clean up
        removed_char = []
        for i in range(len(s)):
            if s[i].isalnum():
                removed_char.append(s[i].lower())
        s = "".join(removed_char)
        for i in range(len(s)/2):
            if s[i]!=s[-(i+1)]:
                return False
        return True
--------

125. Valid Palindrome.

Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Note: For the purpose of this problem, we define empty string as valid palindrome.

Example 1:

Input: "A man, a plan, a canal: Panama"
Output: true
Example 2:

Input: "race a car"
Output: false

class Solution(object):
    def isPalindrome(self, s):
        """
        :type s: str
        :rtype: bool
        """
        if len(s)<=1:
            return True
        # first clean up
        removed_char = []
        for i in range(len(s)):
            if s[i] in ['a','b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l','m','n','o','p','q','r','s','t','u',
                       'v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R',
                       'S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9']:
                removed_char.append(s[i].lower())
        s = "".join(removed_char)
        for i in range(len(s)/2):
            if s[i]!=s[-(i+1)]:
                return False
        return True
------

23. Merge k Sorted Lists.
Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

Example:

Input:
[
  1->4->5,
  1->3->4,
  2->6
]
Output: 1->1->2->3->4->4->5->6

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def mergeKLists(self, lists):
        """
        :type lists: List[ListNode]
        :rtype: ListNode
        """
        from heapq import *
        heap_list = []
        result = ListNode(0)
        result_it = result
        for i in range(len(lists)):
            if lists[i] is not None:
                heappush(heap_list,(lists[i].val,i ))
                lists[i] = lists[i].next
        while len(heap_list)>0:
            cur_min = heappop(heap_list)
            result_it.next = ListNode(cur_min[0])
            result_it = result_it.next
            i = cur_min[1]
            if lists[i] is not None:
                heappush(heap_list,(lists[i].val, i))
                lists[i] = lists[i].next
        return result.next
        
--------

21. Merge Two Sorted Lists.
Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

Example:

Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def mergeTwoLists(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        if l1 is None:
            return l2
        if l2 is None:
            return l1
        l1_it = l1
        l2_it = l2
        result = ListNode(0)
        result_it = result
        while l1_it is not None and l2_it is not None:
            if l1_it.val<l2_it.val:
                result_it.next = ListNode(l1_it.val)
                l1_it = l1_it.next
                result_it = result_it.next
            else:
                result_it.next = ListNode(l2_it.val)
                l2_it = l2_it.next
                result_it = result_it.next
        if l1_it is not None:
            result_it.next = l1_it
        if l2_it is not None:
            result_it.next = l2_it
        return result.next
-------

98. Validate Binary Search Tree.

Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.
Example 1:

Input:
    2
   / \
  1   3
Output: true
Example 2:

    5
   / \
  1   4
     / \
    3   6
Output: false
Explanation: The input is: [5,1,4,null,null,3,6]. The root node's value
             is 5 but its right child's value is 4.


# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def isValidBST(self, root):
        """
        :type root: TreeNode
        :rtype: bool
        """
        stack = list()
        cur_it = root
        if root is None:
            return True
        stack.append([root, False])
        max_so_far = -1e10
        while len(stack)>0:
            if stack[-1][1]== False:
                stack[-1][1] = True
                if stack[-1][0].left is not None:
                    stack.append([stack[-1][0].left,False])
                else:
                    if stack[-1][0].val <= max_so_far:
                        return False
                    else:
                        max_so_far = stack[-1][0].val
                    cur_node = stack[-1][0]
                    stack.pop()
                    if cur_node.right is not None:
                        stack.append([cur_node.right, False])
            else: # time to traverse right
                if stack[-1][0].val <= max_so_far:
                    return False
                else:
                    max_so_far = stack[-1][0].val
                cur_node = stack[-1][0]
                stack.pop()
                if cur_node.right is not None:
                    stack.append([cur_node.right, False])
        return True
            
---------------
141. Linked List Cycle.

Given a linked list, determine if it has a cycle in it.

To represent a cycle in the given linked list, we use an integer pos which represents the position (0-indexed) in the linked list where tail connects to. If pos is -1, then there is no cycle in the linked list.

 

Example 1:

Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where tail connects to the second node.


Example 2:

Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where tail connects to the first node.


Example 3:

Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.


 

Follow up:

Can you solve it using O(1) (i.e. constant) memory?

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def hasCycle(self, head):
        """
        :type head: ListNode
        :rtype: bool
        """
        slow = head
        if head is None or head.next is None:
            return False
        fast = head.next.next
        while slow is not None and fast is not None and fast.next is not None:
            slow = slow.next
            fast = fast.next.next
            if slow==fast:
                return True
        return False
        
-------

160. Intersection of Two Linked Lists.

Write a program to find the node at which the intersection of two singly linked lists begins.

For example, the following two linked lists:


begin to intersect at node c1.

 

Example 1:


Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
Output: Reference of the node with value = 8
Input Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,0,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.
 

Example 2:


Input: intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
Output: Reference of the node with value = 2
Input Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [0,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.
 

Example 3:


Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
Output: null
Input Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
Explanation: The two lists do not intersect, so return null.
 

Notes:

If the two linked lists have no intersection at all, return null.
The linked lists must retain their original structure after the function returns.
You may assume there are no cycles anywhere in the entire linked structure.
Your code should preferably run in O(n) time and use only O(1) memory.

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def getIntersectionNode(self, headA, headB):
        """
        :type head1, head1: ListNode
        :rtype: ListNode
        """
        if headA is None or headB is None:
            return None
        a_it = headA
        b_it = headB
        ln_a = 1
        ln_b = 1
        while a_it is not None:
            a_it = a_it.next
            ln_a += 1
        while b_it is not None:
            b_it = b_it.next
            ln_b +=1
        a_it = headA
        b_it = headB
        if ln_a>ln_b:
            for i in range(ln_a - ln_b):
                a_it = a_it.next
        else:
            for i in range(ln_b - ln_a):
                b_it = b_it.next
        while a_it != b_it and a_it is not None and b_it is not None:
            a_it = a_it.next
            b_it = b_it.next
        if a_it==b_it:
            return a_it
        else:
            return None
        
------
2. Add Two Numbers.
You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example:

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
Explanation: 342 + 465 = 807.

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        if l1 is None or (l1.next is None and l1.val==0):
            return l2
        if l2 is None or (l2.next is None and l2.val==0):
            return l1
        l1_ptr = l1
        l2_ptr = l2
        carry_over = 0
        result = ListNode(0)
        result_ptr = result
        result_ptr.val = (carry_over + l1_ptr.val + l2_ptr.val) % 10
        carry_over = (carry_over + l1_ptr.val + l2_ptr.val) //10
        while l1_ptr.next is not None and l2_ptr.next is not None:
            l1_ptr = l1_ptr.next
            l2_ptr = l2_ptr.next
            result_ptr.next = ListNode(0)
            result_ptr = result_ptr.next
            result_ptr.val = (carry_over + l1_ptr.val + l2_ptr.val) % 10
            carry_over = (carry_over + l1_ptr.val + l2_ptr.val) //10
        if l1_ptr.next is not None and l2_ptr.next is None:
            result_ptr.next = l1_ptr.next
        if l1_ptr.next is None and l2_ptr.next is not None:
            result_ptr.next = l2_ptr.next
        while carry_over>0:
            if result_ptr.next is None:
                result_ptr.next = ListNode(0)
            result_ptr = result_ptr.next
            carry_over, result_ptr.val = (result_ptr.val + carry_over)//10, (result_ptr.val + carry_over)%10
        return result
            
-----

206. Reverse Linked List.

Reverse a singly linked list.

Example:

Input: 1->2->3->4->5->NULL
Output: 5->4->3->2->1->NULL
Follow up:

A linked list can be reversed either iteratively or recursively. Could you implement both?

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def reverseList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        if head is None:
            return head
        cur = head
        nxt = head.next
        if nxt is None:
            return head
        cur.next, nxt.next, cont = None, cur, nxt.next
        cur , nxt = nxt, cont
        while nxt is not None:
            nxt.next, cont =  cur, nxt.next
            cur , nxt = nxt, cont
        return cur
----

42. Trapping Rain Water.
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.


The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

Example:

Input: [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6

class Solution(object):
    def trap(self, height):
        """
        :type height: List[int]
        :rtype: int
        """
        if len(height)==0:
            return 0
        water_level = 0
        left = 0
        right = len(height)-1
        while len(height[left:right+1])>1 and left<=right:
            while left<right and height[left]<=height[left+1]:
                left += 1
            while right>left and height[right]<= height[right-1]:
                right -=1
            if (len(height[left:right+1])>0):
                fill_til = min(height[left], height[right])
                for i in range(left, right+1):
                    if height[i] < fill_til:
                        water_level += fill_til - height[i]
                        height[i] = fill_til
        return water_level
        
                
  ------
  
20. Valid Parentheses.

Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
Note that an empty string is also considered valid.

Example 1:

Input: "()"
Output: true
Example 2:

Input: "()[]{}"
Output: true
Example 3:

Input: "(]"
Output: false
Example 4:

Input: "([)]"
Output: false
Example 5:

Input: "{[]}"
Output: true

class Solution(object):
    def isValid(self, s):
        """
        :type s: str
        :rtype: bool
        """
        if str=="":
            return True
        stack = []
        complement = {'(':')','{':'}', '[':']'}
        for i in range(len(s)):
            if s[i] in ['(', '{', '[']:
                stack.append(s[i])
            else:
                if len(stack)>0 and complement[stack[-1]]==s[i]:
                    del stack[-1]
                else:
                    return False
        if len(stack)==0:
            return True
        else:
            return False

------

65. Valid Number.
Validate if a given string can be interpreted as a decimal number.

Some examples:
"0" => true
" 0.1 " => true
"abc" => false
"1 a" => false
"2e10" => true
" -90e3   " => true
" 1e" => false
"e3" => false
" 6e-1" => true
" 99e2.5 " => false
"53.5e93" => true
" --6 " => false
"-+3" => false
"95a54e53" => false

Note: It is intended for the problem statement to be ambiguous. You should gather all requirements up front before implementing one. However, here is a list of characters that can be in a valid decimal number:

Numbers 0-9
Exponent - "e"
Positive/negative sign - "+"/"-"
Decimal point - "."
Of course, the context of these characters also matters in the input.

Update (2015-02-10):
The signature of the C++ function had been updated. If you still see your function signature accepts a const char * argument, please click the reload button to reset your code definition.


class Solution(object):
    def isNumber(self, s):
        """
        :type s: str
        :rtype: bool
        """
        s = s.strip()
        if s =="":
            return False
        cur_index = 0
        if cur_index<len(s) and (s[cur_index]=='-' or s[cur_index]=='+'):
            cur_index += 1
        number_sw = False
        while cur_index<len(s) and s[cur_index] in ['1','2','3','4','5','6','7','8','9','0']:
            cur_index += 1
            number_sw = True
        if cur_index<len(s) and s[cur_index]=='.':
            cur_index += 1
        while cur_index<len(s) and s[cur_index] in ['1','2','3','4','5','6','7','8','9','0']:
            cur_index += 1
            number_sw = True
        if number_sw == True and cur_index<len(s) and s[cur_index]=='e':
            cur_index += 1
            if cur_index<len(s) and (s[cur_index]=='-' or s[cur_index]=='+'):
                 cur_index += 1
            number_sw = False
        while cur_index<len(s) and s[cur_index] in ['1','2','3','4','5','6','7','8','9','0']:
            cur_index += 1
            number_sw = True
        if cur_index==len(s) and number_sw == True:
            return True
        else:
            return False
        
-------

114. Flatten Binary Tree to Linked List.
Given a binary tree, flatten it to a linked list in-place.

For example, given the following tree:

    1
   / \
  2   5
 / \   \
3   4   6
The flattened tree should look like:

1
 \
  2
   \
    3
     \
      4
       \
        5
         \
          6

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def flatten(self, root):
        """
        :type root: TreeNode
        :rtype: void Do not return anything, modify root in-place instead.
        """
        if root==None:
            return 
        output = self.traverse_pre_order(root)
        output_len = len(output)
        for i in range(output_len-1):
            output[i].left = None
            output[i].right = output[i+1]
        output[output_len-1].left = None
        output[output_len-1].right = None
        return
    def traverse_pre_order(self, node):
        if node is None:
            return None
        else:
            output = []
            output.append(node)
            traverse_left = self.traverse_pre_order(node.left)
            if traverse_left is not None:
                for element in traverse_left:
                    if element is not None:
                        output.append(element)
            traverse_right = self.traverse_pre_order(node.right)
            if traverse_right is not None:
                for element in traverse_right:
                    if element is not None:
                        output.append(element)
        return output
        
-----
19. Remove Nth Node From End of List.

Given a linked list, remove the n-th node from the end of list and return its head.

Example:

Given linked list: 1->2->3->4->5, and n = 2.

After removing the second node from the end, the linked list becomes 1->2->3->5.
Note:

Given n will always be valid.

Follow up:

Could you do this in one pass?

# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def removeNthFromEnd(self, head, n):
        """
        :type head: ListNode
        :type n: int
        :rtype: ListNode
        """
        head_it = head
        temp_arr = []
        start = 0
        temp_arr.append(None)
        for i in range(1,n+1):
            temp_arr.append(head_it)
            head_it = head_it.next
        while head_it is not None:
            temp_arr[start] = head_it
            start = (start+1)%(n+1)
            head_it = head_it.next
        if temp_arr[start] is None:
            return head.next
        temp_arr[start].next = temp_arr[(start+1)%(n+1)].next
        return head
-----

325. Maximum Size Subarray Sum Equals k.

Given an array nums and a target value k, find the maximum length of a subarray that sums to k. If there isn't one, return 0 instead.

Note:
The sum of the entire nums array is guaranteed to fit within the 32-bit signed integer range.

Example 1:

Input: nums = [1, -1, 5, -2, 3], k = 3
Output: 4 
Explanation: The subarray [1, -1, 5, -2] sums to 3 and is the longest.
Example 2:

Input: nums = [-2, -1, 2, 1], k = 1
Output: 2 
Explanation: The subarray [-1, 2] sums to 1 and is the longest.
Follow Up:
Can you do it in O(n) time?

class Solution(object):
    def maxSubArrayLen(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: int
        """
        sum = 0
        max_res = 0
        # key: sum of all elements so far, value: the index so far
        sum_map = dict()
 
        for i, n in enumerate(nums):
            sum += n
            if sum == k:
                max_res = i + 1
            elif sum_map.get(sum-k, None) is not None:
                max_res = max(max_res, i - sum_map[sum-k])
            # if sum already exists in sum_map, its index should be
            # smaller than the current index. Since we want to find
            # the maximum length of subarray, the smaller index
            # should be kept.
            if sum_map.get(sum, None) is None:
                sum_map[sum] = i
        return max_res

-------------

325. Maximum Size Subarray Sum Equals k.

Given an array nums and a target value k, find the maximum length of a subarray that sums to k. If there isn't one, return 0 instead.

Note:
The sum of the entire nums array is guaranteed to fit within the 32-bit signed integer range.

Example 1:

Input: nums = [1, -1, 5, -2, 3], k = 3
Output: 4 
Explanation: The subarray [1, -1, 5, -2] sums to 3 and is the longest.
Example 2:

Input: nums = [-2, -1, 2, 1], k = 1
Output: 2 
Explanation: The subarray [-1, 2] sums to 1 and is the longest.
Follow Up:
Can you do it in O(n) time?

class Solution(object):
    def maxSubArrayLen(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: int
        """
        dict = {0:-1}
        sums = 0
        maxlen = 0
        for i in range(len(nums)):
            sums += nums[i]
            if sums-k in dict:
                maxlen = max(maxlen, i - dict[sums-k])
            dict[sums] = min(dict.get(sums, len(nums)), i)
        return maxlen
        
 ---------

209. Minimum Size Subarray Sum.

Given an array of n positive integers and a positive integer s, find the minimal length of a contiguous subarray of which the sum ≥ s. If there isn't one, return 0 instead.

Example: 

Input: s = 7, nums = [2,3,1,2,4,3]
Output: 2
Explanation: the subarray [4,3] has the minimal length under the problem constraint.
Follow up:
If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log n). 

class Solution(object):
    def minSubArrayLen(self, s, nums):
        """
        :type s: int
        :type nums: List[int]
        :rtype: int
        """
        start = 0
        end = 0
        if sum(nums)<s:
            return 0
        len_nums = len(nums)
        min_size = len_nums
        cur_sum = 0
        while end<len_nums:
            while end<len_nums and cur_sum<s:
                cur_sum += nums[end]
                end+=1
            while start<=end and cur_sum>=s:
                if end-start<min_size and cur_sum>=s :
                    min_size = end - start
                cur_sum -= nums[start]
                start +=1
        return min_size

--------

301. Remove Invalid Parentheses.
Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

Note: The input string may contain letters other than the parentheses ( and ).

Example 1:

Input: "()())()"
Output: ["()()()", "(())()"]
Example 2:

Input: "(a)())()"
Output: ["(a)()()", "(a())()"]
Example 3:

Input: ")("
Output: [""]

class Solution(object):
    def removeInvalidParentheses(self, s):
        """
        :type s: str
        :rtype: List[str]
        """
        def isValid(s):
            a = 0
            for c in s:
                a += {'(' : 1, ')' : -1}.get(c, 0)
                if a < 0:
                    return False
            return a == 0

        visited = set([s])
        ans = []
        queue = collections.deque([s])
        done = False
        while queue:
            t = queue.popleft()
            if isValid(t):
                done = True
                ans.append(t)
            if done:
                continue
            for x in range(len(t)):
                if t[x] not in ('(', ')'):
                    continue
                ns = t[:x] + t[x + 1:]
                if ns not in visited:
                    visited.add(ns)
                    queue.append(ns)

        return ans
------

301. Remove Invalid Parentheses.

Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

Note: The input string may contain letters other than the parentheses ( and ).

Example 1:

Input: "()())()"
Output: ["()()()", "(())()"]
Example 2:

Input: "(a)())()"
Output: ["(a)()()", "(a())()"]
Example 3:

Input: ")("
Output: [""]


class Solution(object):
    def removeInvalidParentheses(self, s):
        """
        :type s: str
        :rtype: List[str]
        """
        def isValid(s):
            a = 0
            for c in s:
                a += {'(' : 1, ')' : -1}.get(c, 0)
                if a < 0:
                    return False
            return a == 0

        visited = set([s])
        ans = []
        queue = collections.deque([s])
        done = False
        while queue:
            t = queue.popleft()
            if isValid(t):
                done = True
                ans.append(t)
            if done:
                continue
            for x in range(len(t)):
                if t[x] not in ('(', ')'):
                    continue
                ns = t[:x] + t[x + 1:]
                if ns not in visited:
                    visited.add(ns)
                    queue.append(ns)

        return ans

-------

301. Remove Invalid Parentheses.

Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

Note: The input string may contain letters other than the parentheses ( and ).

Example 1:

Input: "()())()"
Output: ["()()()", "(())()"]
Example 2:

Input: "(a)())()"
Output: ["(a)()()", "(a())()"]
Example 3:

Input: ")("
Output: [""].

class Solution(object):
    def removeInvalidParentheses(self, s):
        """
        :type s: str
        :rtype: List[str]
        """
        def dfs(s):
            mi = calc(s)
            if mi == 0:
                return [s]
            ans = []
            for x in range(len(s)):
                if s[x] in ('(', ')'):
                    ns = s[:x] + s[x+1:]
                    if ns not in visited and calc(ns) < mi:
                        visited.add(ns)
                        ans.extend(dfs(ns))
            return ans    
        def calc(s):
            a = b = 0
            for c in s:
                a += {'(' : 1, ')' : -1}.get(c, 0)
                b += a < 0
                a = max(a, 0)
            return a + b

        visited = set([s])    
        return dfs(s)

--------

78. Subsets.

Given a set of distinct integers, nums, return all possible subsets (the power set).

Note: The solution set must not contain duplicate subsets.

Example:

Input: nums = [1,2,3]
Output:
[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]

class Solution(object):
    def subsets(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        return self.sub_process(nums, 0)
    def sub_process(self, nums, i):
        if i== len(nums)-1:
            return [[],[nums[i]]]
        sub_sets = self.sub_process(nums, i+1)
        extra_subsets = []
        for subset in sub_sets:
            extra_subsets.append(subset+[nums[i]])
        return sub_sets + extra_subsets
--------

253. Meeting Rooms II.

Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), find the minimum number of conference rooms required.

Example 1:

Input: [[0, 30],[5, 10],[15, 20]]
Output: 2
Example 2:

Input: [[7,10],[2,4]]
Output: 1

# Definition for an interval.
# class Interval(object):
#     def __init__(self, s=0, e=0):
#         self.start = s
#         self.end = e

class Solution(object):
    def minMeetingRooms(self, intervals):
        """
        :type intervals: List[Interval]
        :rtype: int
        """
        start_end_list={}
        for i in intervals:
            if i.start in start_end_list:
                start_end_list[i.start]+= 1
            else:
                start_end_list[i.start] = 1
            if i.end in start_end_list:
                start_end_list[i.end]-= 1
            else:
                start_end_list[i.end] = -1
        available_years = start_end_list.keys()
        available_years.sort()
        max_rooms = 0
        running_rooms = 0
        for i in available_years:
            running_rooms += start_end_list[i]
            if running_rooms>max_rooms:
                max_rooms = running_rooms
        return max_rooms                   
------------


157. Read N Characters Given Read4.

Given a file and assume that you can only read the file using a given method read4, implement a method to read n characters.

 

Method read4:

The API read4 reads 4 consecutive characters from the file, then writes those characters into the buffer array buf.

The return value is the number of actual characters read.

Note that read4() has its own file pointer, much like FILE *fp in C.

Definition of read4:

    Parameter:  char[] buf
    Returns:    int

Note: buf[] is destination not source, the results from read4 will be copied to buf[]
Below is a high level example of how read4 works:

File file("abcdefghijk"); // File is "abcdefghijk", initially file pointer (fp) points to 'a'
char[] buf = new char[4]; // Create buffer with enough space to store characters
read4(buf); // read4 returns 4. Now buf = "abcd", fp points to 'e'
read4(buf); // read4 returns 4. Now buf = "efgh", fp points to 'i'
read4(buf); // read4 returns 3. Now buf = "ijk", fp points to end of file
 

Method read:

By using the read4 method, implement the method read that reads n characters from the file and store it in the buffer array buf. Consider that you cannot manipulate the file directly.

The return value is the number of actual characters read.

Definition of read:

    Parameters:	char[] buf, int n
    Returns:	int

Note: buf[] is destination not source, you will need to write the results to buf[]
 

Example 1:

Input: file = "abc", n = 4
Output: 3
Explanation: After calling your read method, buf should contain "abc". We read a total of 3 characters from the file, so return 3. Note that "abc" is the file's content, not buf. buf is the destination buffer that you will have to write the results to.
Example 2:

Input: file = "abcde", n = 5
Output: 5
Explanation: After calling your read method, buf should contain "abcde". We read a total of 5 characters from the file, so return 5.
Example 3:

Input: file = "abcdABCD1234", n = 12
Output: 12
Explanation: After calling your read method, buf should contain "abcdABCD1234". We read a total of 12 characters from the file, so return 12.
Example 4:

Input: file = "leetcode", n = 5
Output: 5
Explanation: After calling your read method, buf should contain "leetc". We read a total of 5 characters from the file, so return 5.
 

Note:

Consider that you cannot manipulate the file directly, the file is only accesible for read4 but not for read.
The read function will only be called once for each test case.
You may assume the destination buffer array, buf, is guaranteed to have enough space for storing n characters.

# The read4 API is already defined for you.
# @param buf, a list of characters
# @return an integer
# def read4(buf):

class Solution(object):
    def read(self, buf, n):
        """
        :type buf: Destination buffer (List[str])
        :type n: Maximum number of characters to read (int)
        :rtype: The number of characters read (int)
        """
        index = 0
        while True:
            buf4 = [""]*4
            current = min(read4(buf4), n-index) 
            for i in xrange(current):
                buf[index] = buf4[i] 
                index += 1
            if current!=4:
                return index 

------------

277. Find the Celebrity.

Suppose you are at a party with n people (labeled from 0 to n - 1) and among them, there may exist one celebrity. The definition of a celebrity is that all the other n - 1 people know him/her but he/she does not know any of them.

Now you want to find out who the celebrity is or verify that there is not one. The only thing you are allowed to do is to ask questions like: "Hi, A. Do you know B?" to get information of whether A knows B. You need to find out the celebrity (or verify there is not one) by asking as few questions as possible (in the asymptotic sense).

You are given a helper function bool knows(a, b) which tells you whether A knows B. Implement a function int findCelebrity(n). There will be exactly one celebrity if he/she is in the party. Return the celebrity's label if there is a celebrity in the party. If there is no celebrity, return -1.

 

Example 1:


Input: graph = [
  [1,1,0],
  [0,1,0],
  [1,1,1]
]
Output: 1
Explanation: There are three persons labeled with 0, 1 and 2. graph[i][j] = 1 means person i knows person j, otherwise graph[i][j] = 0 means person i does not know person j. The celebrity is the person labeled as 1 because both 0 and 2 know him but 1 does not know anybody.
Example 2:


Input: graph = [
  [1,0,1],
  [1,1,0],
  [0,1,1]
]
Output: -1
Explanation: There is no celebrity.
 

Note:

The directed graph is represented as an adjacency matrix, which is an n x n matrix where a[i][j] = 1 means person i knows person j while a[i][j] = 0 means the contrary.
Remember that you won't have direct access to the adjacency matrix.

# The knows API is already defined for you.
# @param a, person a
# @param b, person b
# @return a boolean, whether a knows b
# def knows(a, b):

class Solution(object):
    def findCelebrity(self, n):
        """
        :type n: int
        :rtype: int
        """
        start = 0
        end = n-1
        while start<end:
            if knows(start, end):
                start += 1
            else:
                end -=1
        for i in range(n):
            if i!=start and (knows(start,i) or not knows(i,start)):
                return -1
        return start

--------

686. Repeated String Match.

Given two strings A and B, find the minimum number of times A has to be repeated such that B is a substring of it. If no such solution, return -1.

For example, with A = "abcd" and B = "cdabcdab".

Return 3, because by repeating A three times (“abcdabcdabcd”), B is a substring of it; and B is not a substring of A repeated two times ("abcdabcd").

Note:
The length of A and B will be between 1 and 10000.

class Solution(object):
    def repeatedStringMatch(self, A, B):
        """
        :type A: str
        :type B: str
        :rtype: int
        """
        A_rep = A
        rep = 1
        while len(A_rep)<=3*len(B) or rep<3:
            if B in A_rep:
                return rep
            A_rep = A_rep + A
            rep+=1
        return -1

--------


91. Decode Ways.

A message containing letters from A-Z is being encoded to numbers using the following mapping:

'A' -> 1
'B' -> 2
...
'Z' -> 26
Given a non-empty string containing only digits, determine the total number of ways to decode it.

Example 1:

Input: "12"
Output: 2
Explanation: It could be decoded as "AB" (1 2) or "L" (12).
Example 2:

Input: "226"
Output: 3
Explanation: It could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).

class Solution(object):
    def numDecodings(self, s):
        """
        :type s: str
        :rtype: int
        """
        n = len(s)
        if s=='0':
            return 0
        else:
            return self.countDecoding(s, n)
    def countDecoding(self,s, n):
        count = [0]*(n+1)
        if s[0]>'0':
            count[0] = 1
            count[1] = 1
        for i in range(2,n+1):
            count[i] = 0
            if (s[i -1]>'0'):
                count[i] = count[i-1]
            if (s[i -2] == '1' or (s[i-2]=='2' and s[i-1]<'7')):
                count[i] += count[i-2]
        return count[n]
-------


426. Convert Binary Search Tree to Sorted Doubly Linked List.

Convert a BST to a sorted circular doubly-linked list in-place. Think of the left and right pointers as synonymous to the previous and next pointers in a doubly-linked list.

Let's take the following BST as an example, it may help you understand the problem better:

 


 
We want to transform this BST into a circular doubly linked list. Each node in a doubly linked list has a predecessor and successor. For a circular doubly linked list, the predecessor of the first element is the last element, and the successor of the last element is the first element.

The figure below shows the circular doubly linked list for the BST above. The "head" symbol means the node it points to is the smallest element of the linked list.

 


 
Specifically, we want to do the transformation in place. After the transformation, the left pointer of the tree node should point to its predecessor, and the right pointer should point to its successor. We should return the pointer to the first element of the linked list.

The figure below shows the transformed BST. The solid line indicates the successor relationship, while the dashed line means the predecessor relationship.

"""
# Definition for a Node.
class Node(object):
    def __init__(self, val, left, right):
        self.val = val
        self.left = left
        self.right = right
"""
class Solution(object):
    pre = None 
    def treeToDoublyList(self, root):
        """
        :type root: Node
        :rtype: Node
        """
        # Set the previous pointer  
        self.fixPrevPtr(root) 

        # Set the next pointer and return head of DLL 
        return self.fixNextPtr(root) 

    # Changes left pointers to work as previous pointers 
    # in converted DLL 
    # The function simply does inorder traversal of  
    # Binary Tree and updates 
    # left pointer using previously visited node
    def fixPrevPtr(self, root): 
        if root is not None: 
            self.fixPrevPtr(root.right) 
            root.right = self.pre 
            self.pre = root  
            self.fixPrevPtr(root.left) 

        
    # Changes right pointers to work as nexr pointers in 
    # converted DLL  
    def fixNextPtr(self, root): 

        prev = None
        # Find the left most node in BT or last node in DLL 
        while(root and root.left != None): 
            root = root.left  
        
        keep_root_to_circulate = root
        
        # Start from the left most node, traverse forward using 
        # right pointers 
        # While traversing, change right pointer of nodes  
        while(root and root.right != None): 
            prev = root  
            root = root.right  
            root.left = prev 
        
        if keep_root_to_circulate:
            keep_root_to_circulate.left = root
            root.right = keep_root_to_circulate
        # The leftmost node is head of linked list, return it 
        return keep_root_to_circulate  


-----

Construct Binary Tree from Preorder and Inorder Traversal
  Go to Discuss
Given preorder and inorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.

For example, given

preorder = [3,9,20,15,7]
inorder = [9,3,15,20,7]
Return the following binary tree:

    3
   / \
  9  20
    /  \
   15   7

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def buildTree(self, preorder, inorder):
        if len(preorder) == 0:
            return None
        if len(preorder) == 1:
            return TreeNode(preorder[0])
        root = TreeNode(preorder[0])
        index = inorder.index(root.val)
        root.left = self.buildTree(preorder[1 : index + 1], inorder[0 : index])
        root.right = self.buildTree(preorder[index + 1 : len(preorder)], 
                                    inorder[index + 1 : len(inorder)])
        return root
-----

Number of Islands
  Go to Discuss
Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

Input:
11110
11010
11000
00000

Output: 1
Example 2:

Input:
11000
11000
00100
00011

Output: 3

class Solution(object):
    def numIslands(self, grid):
        m = len(grid)
        if m == 0:
            return 0
        n = len(grid[0])
        visit = [[False for i in range(n)]for j in range(m)]
        def check(x, y):
            if x >= 0 and x<m and y>= 0 and y< n and grid[x][y] == '1' and visit[x][y] == False:
                return True
        def dfs(x,y):
            nbrow = [1,0,-1,0]
            nbcol = [0,1,0,-1]
            for k in range(4):
                newx = x + nbrow[k]
                newy = y + nbcol[k]
                if check(newx, newy):
                    visit[newx][newy] = True
                    dfs(newx,newy)
        count = 0
        for row in range(m):
            for col in range(n):
                if check(row,col):
                    visit[row][col] = True
                    dfs(row,col)
                    count+=1
        return count

------

Clone Graph
  Go to Discuss
Given the head of a graph, return a deep copy (clone) of the graph. Each node in the graph contains a label (int) and a list (List[UndirectedGraphNode]) of its neighbors. There is an edge between the given node and each of the nodes in its neighbors.


OJ's undirected graph serialization (so you can understand error output):
Nodes are labeled uniquely.

We use # as a separator for each node, and , as a separator for node label and each neighbor of the node.
 

As an example, consider the serialized graph {0,1,2#1,2#2,2}.

The graph has a total of three nodes, and therefore contains three parts as separated by #.

First node is labeled as 0. Connect node 0 to both nodes 1 and 2.
Second node is labeled as 1. Connect node 1 to node 2.
Third node is labeled as 2. Connect node 2 to node 2 (itself), thus forming a self-cycle.
 

Visually, the graph looks like the following:

       1
      / \
     /   \
    0 --- 2
         / \
         \_/
Note: The information about the tree serialization is only meant so that you can understand error output if you get a wrong answer. You don't need to understand the serialization to solve the problem.

# Definition for a undirected graph node
# class UndirectedGraphNode:
#     def __init__(self, x):
#         self.label = x
#         self.neighbors = []

class Solution:
    # @param node, a undirected graph node
    # @return a undirected graph node
    def cloneGraph(self, node):
        if node == None: return None
        queue = []; map = {}
        newhead = UndirectedGraphNode(node.label)
        queue.append(node)
        map[node] = newhead
        while queue:
            curr = queue.pop()
            for neighbor in curr.neighbors:
                if neighbor not in map:
                    copy = UndirectedGraphNode(neighbor.label)
                    map[curr].neighbors.append(copy)
                    map[neighbor] = copy
                    queue.append(neighbor)
                else:
                    # turn directed graph to undirected graph
                    map[curr].neighbors.append(map[neighbor])
        return newhead

 ---------


 Sort Colors
  Go to Discuss
Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.

Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.

Note: You are not suppose to use the library's sort function for this problem.

Example:

Input: [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
Follow up:

A rather straight forward solution is a two-pass algorithm using counting sort.
First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.
Could you come up with a one-pass algorithm using only constant space?

class Solution(object):
    def sortColors(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        lo = 0
        hi = len(nums) - 1
        mid = 0
        while mid <= hi: 
            if nums[mid] == 0: 
                nums[lo],nums[mid] = nums[mid],nums[lo] 
                lo = lo + 1
                mid = mid + 1
            elif nums[mid] == 1: 
                mid = mid + 1
            else: 
                nums[mid],nums[hi] = nums[hi],nums[mid]  
                hi = hi - 1
                

------------

Median of Two Sorted Arrays
  Go to Discuss
There are two sorted arrays nums1 and nums2 of size m and n respectively.

Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

You may assume nums1 and nums2 cannot be both empty.

Example 1:

nums1 = [1, 3]
nums2 = [2]

The median is 2.0
Example 2:

nums1 = [1, 2]
nums2 = [3, 4]

The median is (2 + 3)/2 = 2.5

class Solution(object):
    # def to find median 
    # of two sorted arrays 
    # function to find median of array 
    def findMedianSortedArrays(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: float
        """
        m = len(nums1)
        n = len(nums2)
        if m > n :
            return self.findMedianSortedArrays(nums2, nums1)
        k = (m + n - 1) / 2
        l = 0
        r = min(m, k)
        #start binarysearch
        while l < r:
            midNums1 = (l + r) / 2
            midNums2 = k - midNums1
            if nums1[midNums1] < nums2[midNums2]:
                l += 1
            else:
                r = midNums1
        # after binary search, we almost get the median because it must be between
        # these 4 numbers: A[l-1], A[l], B[k-l], and B[k-l+1] 
    
        # if (n+m) is odd, the median is the larger one between A[l-1] and B[k-l].
        # and there are some corner cases we need to take care of.
        a = max(nums1[l-1] if l > 0  else float('-inf'), nums2[k-l] if k-l >= 0 else float('-inf'))
        if (m + n) & 1 == 1:
            return a
        b = min(nums1[l] if l < m else float('inf'), nums2[k-l+1] if k-l+1 < n else float('inf'))
        return (a+b)/2.0

-----

 Best Time to Buy and Sell Stock
  Go to Discuss
Say you have an array for which the ith element is the price of a given stock on day i.

If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.

Note that you cannot sell a stock before you buy one.

Example 1:

Input: [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
             Not 7-1 = 6, as selling price needs to be larger than buying price.
Example 2:

Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.

class Solution(object):
    def maxProfit(self, prices):
        """
        :type prices: List[int]
        :rtype: int
        """
        if len(prices) <= 1: return 0
        low = prices[0]
        maxprofit = 0
        for i in range(len(prices)):
            if prices[i] < low: low = prices[i]
            maxprofit = max(maxprofit, prices[i] - low)
        return maxprofit

------

Implement Trie (Prefix Tree)
  Go to Discuss
Implement a trie with insert, search, and startsWith methods.

Example:

Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");   
trie.search("app");     // returns true
Note:

You may assume that all inputs are consist of lowercase letters a-z.
All inputs are guaranteed to be non-empty strings.

class TrieNode:
    # Initialize your data structure here.
    def __init__(self):
        self.children = dict()
        self.isWord = False

class Trie:

    def __init__(self):
        self.root = TrieNode()

    # @param {string} word
    # @return {void}
    # Inserts a word into the trie.
    def insert(self, word):
        node = self.root
        for letter in word:
            child = node.children.get(letter)
            if child is None:
                child = TrieNode()
                node.children[letter] = child
            node = child
        node.isWord = True

    # @param {string} word
    # @return {boolean}
    # Returns if the word is in the trie.
    def search(self, word):
        node = self.root
        for letter in word:
            node = node.children.get(letter)
            if node is None:
                return False
        return node.isWord

    # @param {string} prefix
    # @return {boolean}
    # Returns if there is any word in the trie
    # that starts with the given prefix.
    def startsWith(self, prefix):
        node = self.root
        for letter in prefix:
            node = node.children.get(letter)
            if node is None:
                return False
        return True
        


# Your Trie object will be instantiated and called as such:
# obj = Trie()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.startsWith(prefix)

----------

Reservoir Sampling
Reservoir sampling is a family of randomized algorithms for randomly choosing k samples from a list of n items, where n is either a very large or unknown number. Typically n is large enough that the list doesn’t fit into main memory. For example, a list of search queries in Google and Facebook.
So we are given a big array (or stream) of numbers (to simplify), and we need to write an efficient function to randomly select k numbers where 1 <= k <= n. Let the input array be stream[].
A simple solution is to create an array reservoir[] of maximum size k. One by one randomly select an item from stream[0..n-1]. If the selected item is not previously selected, then put it in reservoir[]. To check if an item is previously selected or not, we need to search the item in reservoir[]. The time complexity of this algorithm will be O(k^2). This can be costly if k is big. Also, this is not efficient if the input is in the form of a stream.
It can be solved in O(n) time. The solution also suits well for input in the form of stream. The idea is similar to this post. Following are the steps.
1) Create an array reservoir[0..k-1] and copy first k items of stream[] to it. 2) Now one by one consider all items from (k+1)th item to nth item. …a) Generate a random number from 0 to i where i is index of current item in stream[]. Let the generated random number is j. …b) If j is in range 0 to k-1, replace reservoir[j] with arr[i]

# An efficient Python3 program  
# to randomly select k items 
# from a stream of items 
import random 
# A utility function  
# to print an array 
def printArray(stream,n): 
    for i in range(n): 
        print(stream[i],end=" "); 
    print(); 
  
# A function to randomly select 
# k items from stream[0..n-1]. 
def selectKItems(stream, n, k): 
        i=0;  
        # index for elements 
        # in stream[] 
          
        # reservoir[] is the output  
        # array. Initialize it with 
        # first k elements from stream[] 
        reservoir = [0]*k; 
        for i in range(k): 
            reservoir[i] = stream[i]; 
          
        # Iterate from the (k+1)th 
        # element to nth element 
        while(i < n): 
            # Pick a random index 
            # from 0 to i. 
            j = random.randrange(i+1); 
              
            # If the randomly picked 
            # index is smaller than k, 
            # then replace the element 
            # present at the index 
            # with new element from stream 
            if(j < k): 
                reservoir[j] = stream[i]; 
            i+=1; 
          
        print("Following are k randomly selected items"); 
        printArray(reservoir, k); 
      
# Driver Code 
  
if __name__ == "__main__": 
    stream = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]; 
    n = len(stream); 
    k = 5; 
    selectKItems(stream, n, k); 
  
# This code is contributed by mits 
How does this work? To prove that this solution works perfectly, we must prove that the probability that any item stream[i] where 0 <= i < n will be in final reservoir[] is k/n. Let us divide the proof in two cases as first k items are treated differently.
Case 1: For last n-k stream items, i.e., for stream[i] where k <= i < n  For every such stream item stream[i], we pick a random index from 0 to i and if the picked index is one of the first k indexes, we replace the element at picked index with stream[i]
To simplify the proof, let us first consider the last item. The probability that the last item is in final reservoir = The probability that one of the first k indexes is picked for last item = k/n (the probability of picking one of the k items from a list of size n)
Let us now consider the second last item. The probability that the second last item is in final reservoir[] = [Probability that one of the first k indexes is picked in iteration for stream[n-2]] X [Probability that the index picked in iteration for stream[n-1] is not same as index picked for stream[n-2] ] = [k/(n-1)]*[(n-1)/n] = k/n.
Similarly, we can consider other items for all stream items from stream[n-1] to stream[k] and generalize the proof.
Case 2: For first k stream items, i.e., for stream[i] where 0 <= i < k  The first k items are initially copied to reservoir[] and may be removed later in iterations for stream[k]to stream[n]. The probability that an item from stream[0..k-1] is in final array = Probability that the item is not picked when items stream[k], stream[k+1], …. stream[n-1] are considered = [k/(k+1)] x [(k+1)/(k+2)] x [(k+2)/(k+3)] x … x [(n-1)/n] = k/n

----

Given a set of words (without duplicates), find all word squares you can build from them.

A sequence of words forms a valid word square if the kth row and column read the exact same string, where 0 ≤ k < max(numRows, numColumns).

For example, the word sequence ["ball","area","lead","lady"] forms a word square because each word reads the same both horizontally and vertically.

b a l l
a r e a
l e a d
l a d y
Note:
There are at least 1 and at most 1000 words.
All words will have the exact same length.
Word length is at least 1 and at most 5.
Each word contains only lowercase English alphabet a-z.
Example 1:

Input:
["area","lead","wall","lady","ball"]

Output:
[
  [ "wall",
    "area",
    "lead",
    "lady"
  ],
  [ "ball",
    "area",
    "lead",
    "lady"
  ]
]

Explanation:
The output consists of two word squares. The order of output does not matter (just the order of words in each word square matters).
Example 2:

Input:
["abat","baba","atan","atal"]

Output:
[
  [ "baba",
    "abat",
    "baba",
    "atan"
  ],
  [ "baba",
    "abat",
    "baba",
    "atal"
  ]
]

Explanation:
The output consists of two word squares. The order of output does not matter (just the order of words in each word square matters).

class Solution(object):
    def wordSquares(self, words):
        """
        :type words: List[str]
        :rtype: List[List[str]]
        """
        m = len(words)
        n = len(words[0]) if m else 0
        mdict = collections.defaultdict(set)
        for word in words:
            for i in range(n):
                mdict[word[:i]].add(word)
        matrix = []
        ans = []
        def search(word, line):
            matrix.append(word)
            if line == n:
                ans.append(matrix[:])
            else:
                prefix = ''.join(matrix[x][line] for x in range(line))
                for word in mdict[prefix]:
                    search(word, line + 1)
            matrix.pop()
        for word in words:
            search(word, 1)
        return ans

--------

Minimum Window Substring
  Go to Discuss
Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).

Example:

Input: S = "ADOBECODEBANC", T = "ABC"
Output: "BANC"
Note:

If there is no such window in S that covers all characters in T, return the empty string "".
If there is such window, you are guaranteed that there will always be only one unique minimum window in S.

class Solution(object):
    def minWindow(self, s, t):
        """
        :type s: str
        :type t: str
        :rtype: str
        """
        count1={}; count2={}
        for char in t:
            if char not in count1: count1[char]=1
            else: count1[char]+=1
        for char in t:
            if char not in count2: count2[char]=1
            else: count2[char]+=1
        count=len(t)
        start=0; minSize=100000; minStart=0
        for end in range(len(s)):
            if s[end] in count2 and count2[s[end]]>0:
                count1[s[end]]-=1
                if count1[s[end]]>=0:
                    count-=1
            if count==0:
                while True:
                    if s[start] in count2 and count2[s[start]]>0:
                        if count1[s[start]]<0:
                            count1[s[start]]+=1
                        else:
                            break
                    start+=1
                if minSize>end-start+1:
                    minSize=end-start+1; minStart=start
        if minSize==100000: return ''
        else:
            return s[minStart:minStart+minSize]

---------


Word Search II
  Go to Discuss
Given a 2D board and a list of words from the dictionary, find all words in the board.

Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

Example:

Input: 
words = ["oath","pea","eat","rain"] and board =
[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]

Output: ["eat","oath"]
Note:
You may assume that all inputs are consist of lowercase letters a-z.

class Solution(object):
    def findWords(self, board, words):
        """
        :type board: List[List[str]]
        :type words: List[str]
        :rtype: List[str]
        """
        w, h = len(board[0]), len(board)
        trie = Trie()
        for word in words:
            trie.insert(word)

        visited = [[False] * w for x in range(h)]
        dz = zip([1, 0, -1, 0], [0, 1, 0, -1])
        ans = []

        def dfs(word, node, x, y):
            node = node.childs.get(board[x][y])
            if node is None:
                return
            visited[x][y] = True
            for z in dz:
                nx, ny = x + z[0], y + z[1]
                if nx >= 0 and nx < h and ny >= 0 and ny < w and not visited[nx][ny]:
                    dfs(word + board[nx][ny], node, nx, ny)
            if node.isWord:
                ans.append(word)
                trie.delete(word)
            visited[x][y] = False

        for x in range(h):
            for y in range(w):
                dfs(board[x][y], trie.root, x, y)

        return sorted(ans)

class TrieNode:
    # Initialize your data structure here.
    def __init__(self):
        self.childs = dict()
        self.isWord = False

class Trie:

    def __init__(self):
        self.root = TrieNode()

    # @param {string} word
    # @return {void}
    # Inserts a word into the trie.
    def insert(self, word):
        node = self.root
        for letter in word:
            child = node.childs.get(letter)
            if child is None:
                child = TrieNode()
                node.childs[letter] = child
            node = child
        node.isWord = True

    def delete(self, word):
        node = self.root
        queue = []
        for letter in word:
            queue.append((letter, node))
            child = node.childs.get(letter)
            if child is None:
                return False
            node = child
        if not node.isWord:
            return False
        if len(node.childs):
            node.isWord = False
        else:
            for letter, node in reversed(queue):
                del node.childs[letter]
                if len(node.childs) or node.isWord:
                    break
        return True

-----


  Wildcard Matching
  Go to Discuss
Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*'.

'?' Matches any single character.
'*' Matches any sequence of characters (including the empty sequence).
The matching should cover the entire input string (not partial).

Note:

s could be empty and contains only lowercase letters a-z.
p could be empty and contains only lowercase letters a-z, and characters like ? or *.
Example 1:

Input:
s = "aa"
p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
Example 2:

Input:
s = "aa"
p = "*"
Output: true
Explanation: '*' matches any sequence.
Example 3:

Input:
s = "cb"
p = "?a"
Output: false
Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.
Example 4:

Input:
s = "adceb"
p = "*a*b"
Output: true
Explanation: The first '*' matches the empty sequence, while the second '*' matches the substring "dce".
Example 5:

Input:
s = "acdcb"
p = "a*c?b"
Output: false

class Solution(object):
    def isMatch(self, s, p):
        pPointer=sPointer=ss=0; star=-1
        while sPointer<len(s):
            if pPointer<len(p) and (s[sPointer]==p[pPointer] or p[pPointer]=='?'):
                sPointer+=1; pPointer+=1
                continue
            if pPointer<len(p) and p[pPointer]=='*':
                star=pPointer; pPointer+=1; ss=sPointer;
                continue
            if star!=-1:
                pPointer=star+1; ss+=1; sPointer=ss
                continue
            return False
        while pPointer<len(p) and p[pPointer]=='*':
            pPointer+=1
        if pPointer==len(p): return True
        return False
-------

Clone Graph
  Go to Discuss
Given a reference of a node in a connected undirected graph, return a deep copy (clone) of the graph. Each node in the graph contains a val (int) and a list (List[Node]) of its neighbors.

 

Example:



Input:
{"$id":"1","neighbors":[{"$id":"2","neighbors":[{"$ref":"1"},{"$id":"3","neighbors":[{"$ref":"2"},{"$id":"4","neighbors":[{"$ref":"3"},{"$ref":"1"}],"val":4}],"val":3}],"val":2},{"$ref":"4"}],"val":1}

Explanation:
Node 1's value is 1, and it has two neighbors: Node 2 and 4.
Node 2's value is 2, and it has two neighbors: Node 1 and 3.
Node 3's value is 3, and it has two neighbors: Node 2 and 4.
Node 4's value is 4, and it has two neighbors: Node 1 and 3.
 

Note:

The number of nodes will be between 1 and 100.
The undirected graph is a simple graph, which means no repeated edges and no self-loops in the graph.
Since the graph is undirected, if node p has node q as neighbor, then node q must have node p as neighbor too.
You must return the copy of the given node as a reference to the cloned graph.

# Definition for a undirected graph node
class UndirectedGraphNode:
     def __init__(self, x):
        self.val = x
        self.neighbors = []

class Solution:
    # @param node, a undirected graph node
    # @return a undirected graph node
    def cloneGraph(self, node):
        if node is None: return None
        print Node
        queue = []; map = {}
        newhead = UndirectedGraphNode(node.val)
        queue.append(node)
        map[node] = newhead
        while queue:
            curr = queue.pop()
            for neighbor in curr.neighbors:
                if neighbor not in map:
                    copy = UndirectedGraphNode(neighbor.val)
                    map[curr].neighbors.append(copy)
                    map[neighbor] = copy
                    queue.append(neighbor)
                else:
                    # turn directed graph to undirected graph
                    map[curr].neighbors.append(map[neighbor])
        return newhead
                        
-----


Find Minimum in Rotated Sorted Array
  Go to Discuss
Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e.,  [0,1,2,4,5,6,7] might become  [4,5,6,7,0,1,2]).

Find the minimum element.

You may assume no duplicate exists in the array.

Example 1:

Input: [3,4,5,1,2] 
Output: 1
Example 2:

Input: [4,5,6,7,0,1,2]
Output: 0

class Solution(object):
    def findMin(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        cur = -1e10
        for i in range(len(nums)):
            if cur>nums[i]:
                return nums[i]
            else:
                cur = nums[i]
        return nums[0]
            
------

 Search a 2D Matrix
  Go to Discuss
Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

Integers in each row are sorted from left to right.
The first integer of each row is greater than the last integer of the previous row.
Example 1:

Input:
matrix = [
  [1,   3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]
target = 3
Output: true
Example 2:

Input:
matrix = [
  [1,   3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]
target = 13
Output: false

class Solution(object):
    def searchMatrix(self, matrix, target):
        """
        :type matrix: List[List[int]]
        :type target: int
        :rtype: bool
        """
        if len(matrix)==0:
            return False
        if len(matrix[0])==0:
            return False
        n_row = len(matrix)  
        n_col = len(matrix[0])
        if n_row==1 and n_col==1 and matrix[0][0]==target:
            return True
        start = 0
        end = len(matrix)*len(matrix[0]) - 1
        mid = (end-start)/2 + start
        row = mid//n_col
        col = mid%n_col
        flag = True
        print(row)
        print(col)
        print(mid)
        print(start)
        print(end)
        while mid!=start:
            print(row)
            print(col)
            print(mid)
            print(start)
            print(end)
            if matrix[row][col]==target:
                return True
            if matrix[row][col]<target:
                start = mid
                mid = (end-start)/2 + start
                row = mid//n_col
                col = mid%n_col
            if matrix[row][col]>target:
                end = mid
                mid = (end-start)/2 + start
                row = mid//n_col
                col = mid%n_col
        if col+1< n_col and matrix[row][col+1]==target:
            return True
        if col+1>=n_col and row+1< n_row and matrix[row+1][0]==target:
            return True
        if matrix[row][col]==target:
                return True
        return False

----

  Longest Increasing Subsequence
  Go to Discuss
Given an unsorted array of integers, find the length of longest increasing subsequence.

Example:

Input: [10,9,2,5,3,7,101,18]
Output: 4 
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4. 
Note:

There may be more than one LIS combination, it is only necessary for you to return the length.
Your algorithm should run in O(n2) complexity.
Follow up: Could you improve it to O(n log n) time complexity?

class Solution(object):
    # Binary search (note 
    # boundaries in the caller) 
    # A[] is ceilIndex 
    # in the caller 
    def CeilIndex(self, A, l, r, key): 
        while (r - l > 1): 

            m = l + (r - l)//2
            if (A[m] >= key): 
                r = m 
            else: 
                l = m 
        return r 
    def lengthOfLIS(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        if len(nums)==0:
            return 0
        A = nums
        size = len(nums)
        # Add boundary case, 
        # when array size is one 

        tailTable = [0 for i in range(size + 1)] 
        len_v = 0 # always points empty slot 

        tailTable[0] = A[0] 
        len_v = 1
        for i in range(1, size): 

            if (A[i] < tailTable[0]): 

                # new smallest value 
                tailTable[0] = A[i] 

            elif (A[i] > tailTable[len_v-1]): 

                # A[i] wants to extend 
                # largest subsequence 
                tailTable[len_v] = A[i] 
                len_v+= 1

            else: 
                # A[i] wants to be current 
                # end candidate of an existing 
                # subsequence. It will replace 
                # ceil value in tailTable 
                tailTable[self.CeilIndex(tailTable, -1, len_v-1, A[i])] = A[i] 


        return len_v
                    
----

 LRU Cache
  Go to Discuss
Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

Follow up:
Could you do both operations in O(1) time complexity?

Example:

LRUCache cache = new LRUCache( 2 /* capacity */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4

# Definition for a doubly-linked list node
class Node:
    def __init__(self, key, val):
        self.key = key
        self.val = val
        self.prev = None
        self.next = None

class LRUCache(object):
    # @param capacity, an integer
    def __init__(self, capacity):
        self.capacity = capacity
        self.size = 0
        self.dummyNode = Node(-1, -1)
        self.tail = self.dummyNode
        self.entryFinder = {}

    # @return an integer
    def get(self, key):
        entry = self.entryFinder.get(key)
        if entry is None:
            return -1
        else:
            self.renew(entry)
            return entry.val

    # @param key, an integer
    # @param value, an integer
    # @return nothing
    def put(self, key, value):
        entry = self.entryFinder.get(key)
        if entry is None:
            entry = Node(key, value)
            self.entryFinder[key] = entry
            self.tail.next = entry
            entry.prev = self.tail
            self.tail = entry
            if self.size < self.capacity:
                self.size += 1
            else:
                headNode = self.dummyNode.next
                if headNode is not None:
                    self.dummyNode.next = headNode.next
                    headNode.next.prev = self.dummyNode
                del self.entryFinder[headNode.key]
        else:
            entry.val = value
            self.renew(entry)
        
    def renew(self, entry):
        if self.tail != entry:
            prevNode = entry.prev
            nextNode = entry.next
            prevNode.next = nextNode
            nextNode.prev = prevNode
            entry.next = None
            self.tail.next = entry
            entry.prev = self.tail
            self.tail = entry
            


# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)

--------

 Single Number
  Go to Discuss
Given a non-empty array of integers, every element appears twice except for one. Find that single one.

Note:

Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

Example 1:

Input: [2,2,1]
Output: 1
Example 2:

Input: [4,1,2,1,2]
Output: 4

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        output = 0
        for i in range(len(nums)):
            output = output ^ nums[i]
        return output

-----


 The Skyline Problem
  Go to Discuss
A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Now suppose you are given the locations and height of all the buildings as shown on a cityscape photo (Figure A), write a program to output the skyline formed by these buildings collectively (Figure B).

Buildings  Skyline Contour
The geometric information of each building is represented by a triplet of integers [Li, Ri, Hi], where Li and Ri are the x coordinates of the left and right edge of the ith building, respectively, and Hi is its height. It is guaranteed that 0 ≤ Li, Ri ≤ INT_MAX, 0 < Hi ≤ INT_MAX, and Ri - Li > 0. You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

For instance, the dimensions of all buildings in Figure A are recorded as: [ [2 9 10], [3 7 15], [5 12 12], [15 20 10], [19 24 8] ] .

The output is a list of "key points" (red dots in Figure B) in the format of [ [x1,y1], [x2, y2], [x3, y3], ... ] that uniquely defines a skyline. A key point is the left endpoint of a horizontal line segment. Note that the last key point, where the rightmost building ends, is merely used to mark the termination of the skyline, and always has zero height. Also, the ground in between any two adjacent buildings should be considered part of the skyline contour.

For instance, the skyline in Figure B should be represented as:[ [2 10], [3 15], [7 12], [12 0], [15 10], [20 8], [24, 0] ].

Notes:

The number of buildings in any input list is guaranteed to be in the range [0, 10000].
The input list is already sorted in ascending order by the left x position Li.
The output list must be sorted by the x position.
There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...[2 3], [4 5], [7 5], [11 5], [12 7]...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...[2 3], [4 5], [12 7], ...]

class MaxHeap:
    def __init__(self, buildings):
        self.buildings = buildings
        self.size = 0
        self.heap = [None] * (2 * len(buildings) + 1)
        self.lineMap = dict()
    def maxLine(self):
        return self.heap[1]
    def insert(self, lineId):
        self.size += 1
        self.heap[self.size] = lineId
        self.lineMap[lineId] = self.size
        self.siftUp(self.size)
    def delete(self, lineId):
        heapIdx = self.lineMap[lineId]
        self.heap[heapIdx] = self.heap[self.size]
        self.lineMap[self.heap[self.size]] = heapIdx
        self.heap[self.size] = None
        del self.lineMap[lineId]
        self.size -= 1
        self.siftDown(heapIdx)
    def siftUp(self, idx):
        while idx > 1 and self.cmp(idx / 2, idx) < 0:
            self.swap(idx / 2, idx)
            idx /= 2
    def siftDown(self, idx):
        while idx * 2 <= self.size:
            nidx = idx * 2
            if idx * 2 + 1 <= self.size and self.cmp(idx * 2 + 1, idx * 2) > 0:
                nidx = idx * 2 + 1
            if self.cmp(nidx, idx) > 0:
                self.swap(nidx, idx)
                idx = nidx
            else:
                break
    def swap(self, a, b):
        la, lb = self.heap[a], self.heap[b]
        self.lineMap[la], self.lineMap[lb] = self.lineMap[lb], self.lineMap[la]
        self.heap[a], self.heap[b] = lb, la
    def cmp(self, a, b):
        return self.buildings[self.heap[a]][2] - self.buildings[self.heap[b]][2]
class Solution(object):
    def getSkyline(self, buildings):
        """
        :type buildings: List[List[int]]
        :rtype: List[List[int]]
        """
        size = len(buildings)
        points = sorted([(buildings[x][0], x, 's') for x in range(size)] + 
                        [(buildings[x][1], x, 'e') for x in range(size)])
        maxHeap = MaxHeap(buildings)
        ans = []
        for p in points:
            if p[2] == 's':
                maxHeap.insert(p[1])
            else:
                maxHeap.delete(p[1])
            maxLine = maxHeap.maxLine()
            height = buildings[maxLine][2] if maxLine is not None else 0
            if len(ans) == 0 or ans[-1][0] != p[0]:
                ans.append([p[0], height])
            elif p[2] == 's':
                ans[-1][1] = max(ans[-1][1], height)
            else:
                ans[-1][1] = min(ans[-1][1], height)
            if len(ans) > 1 and ans[-1][1] == ans[-2][1]:
                ans.pop()
        return ans

----

Word Break
  Go to Discuss
Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words.

Note:

The same word in the dictionary may be reused multiple times in the segmentation.
You may assume the dictionary does not contain duplicate words.
Example 1:

Input: s = "leetcode", wordDict = ["leet", "code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".
Example 2:

Input: s = "applepenapple", wordDict = ["apple", "pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
             Note that you are allowed to reuse a dictionary word.
Example 3:

Input: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
Output: false

class Solution(object):
    def wordBreak(self, s, wordDict):
        """
        :type s: str
        :type wordDict: List[str]
        :rtype: bool
        """
        segmented = [True];
        for i in range (0, len(s)):
            segmented.append(False)
            for j in range(i,-1,-1):
                if segmented[j] and s[j:i+1] in wordDict:
                    segmented[i+1] = True
                    break
        return segmented[len(s)]


-----

  Moving Average from Data Stream
  Go to Discuss
Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

Example:

MovingAverage m = new MovingAverage(3);
m.next(1) = 1
m.next(10) = (1 + 10) / 2
m.next(3) = (1 + 10 + 3) / 3
m.next(5) = (10 + 3 + 5) / 3
 
class MovingAverage(object):

    def __init__(self, size):
        """
        Initialize your data structure here.
        :type size: int
        """
        self.items = [0]* size
        self.cur_item = 0
        self.size = size
        self.fill = 0
        self.sum = 0
        

    def next(self, val):
        """
        :type val: int
        :rtype: float
        """
        self.sum -= self.items[self.cur_item] 
        self.sum += val
        self.items[self.cur_item]  = val
        self.fill += 1
        self.cur_item += 1
        self.cur_item %= self.size
        if self.fill> self.size:
            return float(self.sum)/self.size
        else:
            return float(self.sum)/self.fill
        


# Your MovingAverage object will be instantiated and called as such:
# obj = MovingAverage(size)
# param_1 = obj.next(val)

----
  Peeking Iterator
  Go to Discuss
Given an Iterator class interface with methods: next() and hasNext(), design and implement a PeekingIterator that support the peek() operation -- it essentially peek() at the element that will be returned by the next call to next().

Example:

Assume that the iterator is initialized to the beginning of the list: [1,2,3].

Call next() gets you 1, the first element in the list.
Now you call peek() and it returns 2, the next element. Calling next() after that still return 2. 
You call next() the final time and it returns 3, the last element. 
Calling hasNext() after that should return false.
Follow up: How would you extend your design to be generic and work with all types, not just integer?

# Below is the interface for Iterator, which is already defined for you.
#
# class Iterator(object):
#     def __init__(self, nums):
#         """
#         Initializes an iterator object to the beginning of a list.
#         :type nums: List[int]
#         """
#
#     def hasNext(self):
#         """
#         Returns true if the iteration has more elements.
#         :rtype: bool
#         """
#
#     def next(self):
#         """
#         Returns the next element in the iteration.
#         :rtype: int
#         """

class PeekingIterator(object):
    def __init__(self, iterator):
        """
        Initialize your data structure here.
        :type iterator: Iterator
        """
        self.iterator = iterator
        self.cur = self.iterator.next() if self.iterator.hasNext() else None
 
    def peek(self):
        """
        Returns the next element in the iteration without advancing the iterator.
        :rtype: int
        """
        return self.cur
 
    def next(self):
        """
        :rtype: int
        """
        val = self.cur
        self.cur = self.iterator.next() if self.iterator.hasNext() else None
        return val
 
    def hasNext(self):
        """
        :rtype: bool
        """
        return self.cur is not None
        

# Your PeekingIterator object will be instantiated and called as such:
# iter = PeekingIterator(Iterator(nums))
# while iter.hasNext():
#     val = iter.peek()   # Get the next element but not advance the iterator.
#     iter.next()         # Should return the same value as [val].

-------
Maximum Vacation Days
  Go to Discuss
LeetCode wants to give one of its best employees the option to travel among N cities to collect algorithm problems. But all work and no play makes Jack a dull boy, you could take vacations in some particular cities and weeks. Your job is to schedule the traveling to maximize the number of vacation days you could take, but there are certain rules and restrictions you need to follow.

Rules and restrictions:
You can only travel among N cities, represented by indexes from 0 to N-1. Initially, you are in the city indexed 0 on Monday.
The cities are connected by flights. The flights are represented as a N*N matrix (not necessary symmetrical), called flights representing the airline status from the city i to the city j. If there is no flight from the city i to the city j, flights[i][j] = 0; Otherwise, flights[i][j] = 1. Also, flights[i][i] = 0 for all i.
You totally have K weeks (each week has 7 days) to travel. You can only take flights at most once per day and can only take flights on each week's Monday morning. Since flight time is so short, we don't consider the impact of flight time.
For each city, you can only have restricted vacation days in different weeks, given an N*K matrix called days representing this relationship. For the value of days[i][j], it represents the maximum days you could take vacation in the city i in the week j.
You're given the flights matrix and days matrix, and you need to output the maximum vacation days you could take during K weeks.

Example 1:
Input:flights = [[0,1,1],[1,0,1],[1,1,0]], days = [[1,3,1],[6,0,3],[3,3,3]]
Output: 12
Explanation: 
Ans = 6 + 3 + 3 = 12. 

One of the best strategies is:
1st week : fly from city 0 to city 1 on Monday, and play 6 days and work 1 day. 
(Although you start at city 0, we could also fly to and start at other cities since it is Monday.) 
2nd week : fly from city 1 to city 2 on Monday, and play 3 days and work 4 days.
3rd week : stay at city 2, and play 3 days and work 4 days.
Example 2:
Input:flights = [[0,0,0],[0,0,0],[0,0,0]], days = [[1,1,1],[7,7,7],[7,7,7]]
Output: 3
Explanation: 
Ans = 1 + 1 + 1 = 3. 

Since there is no flights enable you to move to another city, you have to stay at city 0 for the whole 3 weeks. 
For each week, you only have one day to play and six days to work. 
So the maximum number of vacation days is 3.
Example 3:
Input:flights = [[0,1,1],[1,0,1],[1,1,0]], days = [[7,0,0],[0,7,0],[0,0,7]]
Output: 21
Explanation:
Ans = 7 + 7 + 7 = 21

One of the best strategies is:
1st week : stay at city 0, and play 7 days. 
2nd week : fly from city 0 to city 1 on Monday, and play 7 days.
3rd week : fly from city 1 to city 2 on Monday, and play 7 days.
Note:
N and K are positive integers, which are in the range of [1, 100].
In the matrix flights, all the values are integers in the range of [0, 1].
In the matrix days, all the values are integers in the range [0, 7].
You could stay at a city beyond the number of vacation days, but you should work on the extra days, which won't be counted as vacation days.
If you fly from the city A to the city B and take the vacation on that day, the deduction towards vacation days will count towards the vacation days of city B in that week.
We don't consider the impact of flight hours towards the calculation of vacation days.

class Solution(object):
    def maxVacationDays(self, flights, days):
        """
        :type flights: List[List[int]]
        :type days: List[List[int]]
        :rtype: int
        """
        N, K = len(days), len(days[0])
        dp = [0] + [-1] * (N - 1)
        for w in range(K):
            ndp = [x for x in dp]
            for sc in range(N):
                if dp[sc] < 0: continue
                for tc in range(N):
                    if sc == tc or flights[sc][tc]:
                        ndp[tc] = max(ndp[tc], dp[sc] + days[tc][w])
            dp = ndp
        return max(dp)
-------------

56. Merge Intervals
Medium

1811

137

Favorite

Share
Given a collection of intervals, merge all overlapping intervals.

Example 1:

Input: [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
Example 2:

Input: [[1,4],[4,5]]
Output: [[1,5]]
Explanation: Intervals [1,4] and [4,5] are considered overlapping.

# Definition for an interval.
# class Interval(object):
#     def __init__(self, s=0, e=0):
#         self.start = s
#         self.end = e

class Solution(object):
    def merge(self, intervals):
        """
        :type intervals: List[Interval]
        :rtype: List[Interval]
        """
        intervals.sort(key = lambda x:x.start) 
        length = len(intervals) 
        res = [] 
        for i in range(length): 
            if res== []: 
                res.append(intervals[i]) 
            else : 
                size = len(res) 
                if res[size-1].start<=intervals[i].start<=res[size-1 ].end: 
                      res[size -1].end=max(intervals[i].end, res[size-1 ].end) 
                else : 
                      res.append(intervals[i]) 
        return res 

-------------


















# coding: utf-8

# ------------------------------------------
# ### Meisam Hejazi Nia
# ### Started on 06/11/2016
# -----------------------------------------
# ### My attitude & approach:
# * Watch movie and write code at the same time?
# * Watch movie is like programming with someone (they act, I program)
# * like having friend
# * The task should be fun & not pushing anymore
# * if I am unhappy or weak, I can still win by being wise
# * not look at past and bad experience as lost 
# * but take my success from them by becoming strong 
# * (I have won those situations)
# ### Goal: 
# * become Patient
# * become convenient
# * start again
# * be courageous
# * not allow anything or anybody negative to enter my mind
# ### Key Ideas:
# * be relaxed like play game
# * Key: No constraint
# * Patient and cool (like AUT Ashkan)
# * Screen management (movie half, half doing)
# * focus on one problem at a time
# * Infinite time & unconstraint optimization
# ## Programming should be fun
# ### Approach: 
# * code in C++/Java
# * Like Puzzle
# ### ACM, GMAT love, but better
# ### Like Knewton GMAT
# ### Math olympiad, but more fun & better
# ### Not everything with the same weight
# ### Like Dirichlet Process
# ----------------------------------------------
# ### Scenario One: Hackathon 3 days
# 

# In[1]:

# Magic of XOR
# replace at the same place (swap without any new variable)
a = 3
b = 5
a = a ^ b # create an element that has the information of both and with interaction with each creates the other
b = a ^ b # a ^ b ^ b and as (b^b) is all zeros, it returns a
a = a ^ b # now given the a that we have put in b and the interaction we have in a, we can build b and put in a


# *------------------------------------------
# #### Problem 5.1: Page 58, computing parity
# * How would you go about computing the parity of a very large number
# * of 64-bit nonnegative integers?
# *------------------------------------------

# In[3]:

N = 588999234332
tmp = N
parity = 0
while tmp!=0:
	parity = parity ^ (tmp %2)
	tmp = tmp/2
	
#C++ version solution
# short parity1(unsigned long x){
#	short result = 0;
#	while (x){
#		result ^= (x & 1);
#		x >>= 1
#	}
#	return result;
#}

# python test
def parity1(x):
	result = 0
	while x:
		result = result ^ (x & 1)
		x = x >> 1
	return result

# test parity1
print(parity1(7)) #1
print(parity1(9)) #0
print(parity1(10)) #0
print(parity1(11)) #1


# In[4]:

#********
# to improve performance:
# A neat trick that erases the least Significantbit of a number in a single operations
# C++ second version
# short parity2(unsign long x){
#	short result = 0;
#	while (x){
#		result ^= 1
#		x &= (x-1); // dropes the LBS of x
#	}
#	return result; 
#}

#improvement by not going sequentially but dropping the first one (less significant one, like jumping)
def parity2(x):
	result = 0
	while x:
		#print 'Before: x:%s, result:%s'%(x,result)
		result = result ^1 # as in the next step I am dropping the first one then just xor with the current result is enough
		x = x & (x-1) #drops the LBS of x (intuitively this operation makes all zero ending one, and the first one ending zero, so drops the first one)
		#print 'After: x:%s, result:%s'%(x,result)
	return result

# test parity2
print(parity2(7)) #1
print(parity2(9)) #0
print(parity2(10)) #0
print(parity2(11)) #1


# In[5]:

#**********
# Third solution: accomodating large number of parity operations
#	precompute an answer and store in the array
# 	vary size of the lookup table based on amount of memory in cache
# "precompute_parity" is the lookup table
#		 stores the parity of any 16-bitnumber ias
#		 precomputed_pari ty (i].
# construct the array during static initialization or dynamically
# flag bit can be used to indicate if the entry at a location is uninitialize
# Once you have this array, you can implement the parity function
#**********
# C++ version
# short parity3(const unsign long &x){
#		return precomputed_parity[x>>48] ^
#			precomputed_parity[(x>>32) & 0XFFFF]
#			precompute_parity[(x>>16) & 0XFFFF]
#			precomputed_parity[x & 0XFFFF];
#}
#================================================================================================


# **************************************************
# #### Problem 5.2: p58 Swap bits
# - accelerate bit manipulation
# - x & (x-1) : least significant bit of x cleared
# - x & ~(x-1): extract lowest bit of x (all other bits are cleared)
# -x ^ (x>>1): standard (binary-reflected) Gray code for x
# ***************************************************

# ### problem 5.2 (page 59)
# * take 64 bit x, and swap bit i and j (0 least signif, 63 most significant bit)

# In[6]:

def problem52(x,i,j):
	# first get bit i
	biti = x&(2**i)
	bitj = x&(2**j)
	# if biti is one and bitj is zero
	if (biti>0 and bitj==0):
		x = x | (2**j)
		x = x ^ (2**i)
		# if biti is zero and bitj is one
	elif (biti==0 and bitj>0):
		x = x |(2**i)
		x = x ^ (2**j)
	#else both are zero or one so it doesn't matter
	return x

#test
print(problem52(8,4,3))
print(problem52(8,3,4))
print(problem52(16,3,4))
print(problem52(3,0,2))


# In[7]:

# solution in page 185 (C++ iss like writing code in R)
#long swap_bits(long x, const int &i, const int &j) {
#	% first check if bit i and j are different
#	if (((x >> i) & 1) != ((x >> j) & 1)) {
#		x ^= (1L << i) | (1L << j);
#	}
# return x;
#}

# python translation
def swap_bits(x, i, j):
	# first check if bit i and j are different
	if (((x>>i) & 1) != ((x>>j) & 1)):
		x = x ^ ((1 << i) | (1 << j))
	return x

print(swap_bits(8,4,3))
print(swap_bits(8,3,4))
print(swap_bits(16,3,4))
print(swap_bits(3,0,2))


# ------------------
# ### Problem 5.5: page 59:
# * Implement a method that takes as input a set S of distinct elements),
# * and prints the power set of S. Print the subsets one per line, 
# * with elements separated by commas.
# * solution: 186
# ------------------

# In[8]:

# read from the screen (comma separated)
#x = input('Please enter the input.')
x = raw_input('Please enter the input.')
setMembers = x.split(',')
# solution 1: it is exponential, but it can be done by breath first
# removing algorithm, start to remove from the candidate sets
#print first item
#print(setMembers)
candidateSet = [setMembers]
while (candidateSet!=[]):
	newCandidateSet = set()
	for curList in candidateSet:
		item = list(curList)
		if (item !=[]):
				print(item)
		#print ('current item is: %s'%item)
		for subItem in item:
			#print(subItem)
			newSet = list(item)
			#print ('current item is: %s'%newSet)
			newSet.remove(subItem)
			#print('new set should include %s'%list(item).remove(subItem))
			if (subItem !=[]):
				newCandidateSet.add(tuple(newSet))
	candidateSet=list(newCandidateSet)

print([])


# In[9]:

#solution:
# The key to solving this problem is realizing that for a given ordering 
# of the elements of S,there exists a one-to-onecorrespondence between
# the 2^|S| bit arrays of length |S| and the set of all subsets of S
# template <typename T>
# void generate_power_set(const vector<T> &S){
#	for (int i=0; i< (1<<S.size()); ++i){
#		int x = i;
#		while (x) {
#			% extract lowest bit of x (all other bits are cleared)
#			int tar = log2(x & ~(x-1));
#			cout << S[tar]
#			if (x &= x-1){
#				cout << ',';
#			}
#		}
#		cout << endl;
#	}
#}

#python translation
import math
def generate_power_set(S):
	for i in range(0,(1<<len(S))):
		#print(i),
		x = i
		while x :
			tar = int(math.log(x & ~(x-1),2))
			print S[tar],
			x = x & (x-1)
			if x:
				print ",",
		print

x = raw_input('Please enter the input.')
setMembers = x.split(',')
generate_power_set(setMembers)


# ------------------
# ### Problem 5.6: Page 60:
# ### Languages such as C++ and Java have library functions for performing this
# * conversion-"stoi" in C++ and "parseInt" in Java go from strings to integers;
# * "to_string" in C++ and "toString" in Java go from integers to strings.
# ### Problem Statement:
# * Implement string/integer inter-conversion functions. Use the following
# * function signatures: 
# * String intToString(int x) 
# * int stringToInt(String s)
# * Answer on page 187
# ------------------

# In[10]:

def intToString(x):
	neg = 0
	if (x <0):
		x = -x
		neg = 1
	output = ""
	while (x):
		d = divmod(x,10)[1]
		#print(d)
		x = x/ 10
		output = (chr(ord('0')+d))+ output
	if neg == 1:
		output = '-' + output
	if output == '':
		output = '0'
	return output

intToString(23)
intToString(-23)
intToString(0)
def stringToInt(s):
	output = 0
	start = 0
	neg = 0
	if s[start]=='-':
		neg = 1
		start = 1
	for i in range(start,len(s)):
		if (ord(s[i])>= ord('0')) and (ord(s[i])<= ord('9')):
			output = 10*output + (ord(s[i])-ord('0'))
		else:
			# consider the problem of order out
			raise ValueError('illegal input')
	if neg == 1:
		output = output*(-1)
	return output

print(stringToInt('23'))
print(stringToInt('-23'))
print(stringToInt('0'))


# In[11]:

#solution
# string intToString(int x){
#	bool is_negative;
#	if (x<0){
#		x = -x, is_negative = true;
#	}else{
#		is_negative = false;
#	}
#	string s;
#	while (x){
#		s.push_back('0'+ x %10);
#		x /= 10;
#	}
#	if (s.empty()){
#		s.push_back('-');
#	}
#	if (is_negative){
#		s.push_back('-');
#	}
#	reverse(s.begin(),s.end());
#	return s;
#}

#int stringToInt(const string &s){
#	bool is_negative = s[0] == '0';
#	int x = 0;
#	for (int i = is_negative; i<s.size(); ++i){
#		if (isdigit(s[i])){
#			x = x*10 + s[i] - '0';
#		}else{
#			throw invalid_argument("illegal input");
#		}
#	}
#	return is_negative ? -x : x;
#}


# ------------------
# ### Chapter on Arrays and Strings
# * in Array, retrieving and updating A[i] takes O(1) time
# * size of array is fixed, so adding more than no objects impossible
# * Deletion at location in handled by ausiliary boolean associated
#     * with the location i indicating whether entry is valid
# * Insertion of object into full array by allocating new array
#     * with additional memory and copying over the entries
#     * from the original array => worse time of insertation high
# * if the new array twice the space of origin array 
#     * constant insertion (b/c copy array is infrequent)
#     * formalization by amortized analysis

# ------------------
# ### Quick Sort algorithm:
#     * selects an element x (the pivot or center), reorders the array
#         * to make all elements less than or equal to x appear first
#         * followed by all the elements greater than x
#         * the two sub arrays are then sorted recursively
#     * Naive implementation => large run time on arrays with 
#         * many duplicates
#     *  Solution: (Dutch national flag partitioning)
#             * reorder the array so that less than x elements appear first
#             * followed by elements equal to x
#             * followed by elements greater than x

# ------------------------------
# * Counting Sort:
#     * when arary consists of entries from a small set of keys, e.g. {0,1,2}
#         * count the number of occurance of each key
#         * enumerate the keys in sorted order and 
#         * write the corresponding number of keys to the arry
#     * if BST is used for counting => time complexity O(n.log(k))
#         * n: array length
#         * k: number of keys
#     * not differentiate between objects with the same key value
# -----------------------------------

# -------------------------
# #### Problem 6.1 on page 64
# - answer on page 183
# - Write a function that takes an array A and an index i into A
# - rearranges the elements such that all elements less than A[i] appear first
# - followed by elements greater than A[i]
# - Algorithm shuld have O(1) space complexity and O(|A|) time complexity
# -------------------------

# In[12]:

A = [5,7,1,2,3,7,8,9,12,1,2,5,4]
# first put everything lower equal at the right side and 
# 	greater equal on the left side
# 	then put everything equal at the end
i = 3
def dutchFlag(A,i):
	pivot = A[i]
	end = len(A) - 1
	start = 0
	# first in one pass the first portion lower and the second higher
	while (start <= end):
		print(A)
		while (A[start]<= pivot):
			start = start + 1
		while (A[end]>pivot):
			end = end - 1
		if ((A[start]>A[end]) and (start<=end)):
			A[start] = A[start] ^ A[end]
			A[end] = A[end] ^ A[start]
			A[start] = A[end] ^ A[start]
	# second pass start with the pivot point and put equal ones at the end
	mid = min(start,end)
	start = 0
	while (start<mid):
		print(A)
		while (A[start]<pivot):
			start = start + 1
		while (A[mid]==pivot):
			mid = mid - 1
		if ((A[start]>A[mid]) and (start<mid)):
			A[start] = A[start] ^ A[mid]
			A[mid] = A[mid] ^ A[start]
			A[start] = A[mid] ^ A[start]
	return (A)

A = [5,7,1,2,3,7,8,9,12,1,2,5,4]
dutchFlag(A,4)


# In[13]:

# book solution:
# include three groups:
# bottom: A[0:smaller-1]
# middle: A[smaller:equal-1]
# unclassified: A[equal:larger]
# top: A[larger+1:|A|-1]
# each iteration decreases the size of unclassified group by 1
# the time spent within each iteration is constant, implying the time complexity of tt(|A|)
#template <typename T>
#void dutch_flag_partition(vector<T> &A, const int &pivot_index){
#	T pivot = A[pivot_index];
# /**
#	* Keep the following invariants during partitioning:
#	* bottom group: A[0: smaller -1]
#	* unclassified group: A[equal : larger]
#	* top group: A[larger + 1: A.size() -1]
#	*/
#	int smaller = 0, euql =0, larger = A.size() -1;
#	// When there is any unclassified element
#	while (equal<=larger){
#		if (A[equal]<pivot){
#			swap(A[smaller++],A[equal++]);
#		} else if (A[equal]==pivot){
#			++equal;
#		}else{ // A[equal]>pivot
#			swap(A[equal],A[larger--])
#		}
#	}
#}


# In[14]:

#Python translation of the solution
def swap(first,second):
	first = first ^ second
	second = first ^ second
	first = first ^ second
	return first,second
def dutch_flag_partition(A,pivot_index):
	pivot = A[pivot_index]
	smaller = 0
	equal = 0
	larger=len(A)-1
	while (equal<=larger):
		if (A[equal]<pivot):
			A[smaller], A[equal] = swap(A[smaller], A[equal])
			smaller = smaller + 1
			equal = equal + 1
		elif (A[equal]==pivot):
			equal = equal + 1
		else: #A[equal]>pivot
			A[equal], A[larger] = swap(A[equal], A[larger])
			larger = larger - 1
	return(A)

A = [5,7,1,2,3,7,8,9,12,1,2,5,4]
dutch_flag_partition(A,2)


# ### Other concepts:
# 1. Lazy initialization, allocate an array arbitrarily but not with O(n)
#     * write indices to a hashtable, and hash codes shall be spread out, to avoid rehashing
# 2. Max difference in an array: max i>j (A[i]-A[j])
#     * application: stock quote, ascent and descent of robot charge and re-charge (limited capacity battery) => find min capacity
# 3. Generalized max difference:
# 4. Subset summing to zero mod n
#     * finding a nonempty subset of the indicesofA whose subset sum is 0 mod n
#     * in general this is NP-complete problem
#     * 0 mod n-sum subset problem can be solved efficiently
#     * n is the length of the underlying array as well as the divisor.
# 5. LONGEST CONTIGUOUS INCREASING SUBARRAY
# 6. COMPUTING EQUIVALENCE CLASSES
# 7. Big integer multiplication when integer is represented as string
# 8. Compute permutation using constant storage
# 9. Update A array of integer to represent invert of the premutation using constant storage
# 10. Lexiographic ordering if in the first place that two vector differ the element for the first is lower than the element for the second
#     * given a permutation return the next premutation using lexographic ordering
# 11. Rotat an array

# ----------------------------------------------------------------
# ### 6.14 SUDOKU CHECKER  (logic-basedcombinatorialnumber placement puzzle)
# - to fill a 9x9 grid with digits subject to the constraint that each column column, eachrow,
# - and each of the nine 3 x 3 sub-grids that compose the grid contains unique integers in [1,9].
# - The grid is initialized with a partial assignment
# ### Problem on page 68
# - Solution on page 197
# - Problem 6.14: Check whether a 9 x 9 2D array representing a partially completed Sudoku is valid. 
# - Specifically,check that no row, column, and 3 x 3 2D subarray contains duplicates. 
# - A 0-value in the 2D array indicates that entry is blank; every other entry is in [1,9]. 
# ----------------------------------------------------------------

# In[15]:

# magin square creation:
# A magic square is an N×N grid of numbers in which the entries in each row, column and main diagonal sum to the same number (equal to  N(N^2+1)/2).
import numpy as np
N = 5 
magic_square = np.zeros((N,N),dtype = int)
i, j = 0, N//2
n = 1
while n<= N**2:
	magic_square[i,j] = n
	n +=1
	newi, newj = (i-1) % N, (j+1) % N
	if magic_square[newi,newj]:
		i += 1
	else:
		i, j = newi, newj
print magic_square


# In[16]:

# back to the actual problem
# use numpy array
# to find duplicates write a function that gets a numpy array, and flattens it and checks for duplicates using hashtable
def duplicateCheck(subArray):
	counter = {}
	tmpArray = subArray.flatten()
	for element in tmpArray:
		if not element==0:
			try:
				counter[element] += 1
			except:
				counter[element] = 1
	if sum(counter.values())==len(counter.values()):
		return False
	else:
		return True
def checkSudoku(inputArray):
	# check the rows for duplicates (not zero, but 1-9)
	for i in range(0,inputArray.shape[0]):
		curArray = inputArray[i,:]
		if duplicateCheck(curArray):
			return False
	# check the columns for duplicates (not	zero, but 1-9)
	for j in range(0,inputArray.shape[1]):
		curArray = inputArray[:,j]
		if duplicateCheck(curArray):
			return False
	# check 3x3 for duplicates (not zero, but 1-9)
	for i in range(0,inputArray.shape[0]-3):
		for j in range(0,inputArray.shape[1]-3):
			curArray = inputArray[i:(i+3),j:(j+3)]
			if duplicateCheck(curArray):
				return False
	return True
	
import numpy as np
tmpArrayColumn = np.array([[1,2,3,4,5,6,7,8,9]])
tmpArray = np.repeat(tmpArrayColumn, 9, axis=0)
checkSudoku(tmpArray)
zeroArray = np.zeros([9,9],dtype=int)
checkSudoku(zeroArray)


# In[18]:

# // use bit arrays to test for constraint violation
# // ensure no number in [1,9] appears more than once
# // Check if a partially filled matrix has any conflicts
# bool is_valid_Sudoku(const vector<vector<int>> &A){
# 	// Check row constraints
# 	for (int i=0; i< A.size(); ++i){
# 		vector<bool> is_present(A.size()+1, false);
# 		for (int j=0; j<A.size(); ++j) {
# 			if (A[i][j] != 0 && is_present[A[i][j]]==true){
# 				return false;
# 			} else {
# 				is_present[A[i][j]] = true;
# 			}
# 		}
# 	}

# 	// Check column constraints
# 	for (int j=0; j< A.size(); ++j){
# 		vector<bool> is_present(A.size() +1, false);
# 		for (int i=0; i<A.zie(); ++i){
# 			if (A[i][j]!=0 && is_present[A[i][j]] == true){
# 				return false;
# 			} else{
# 				is_present[A[i][j]] = true;
# 			}
# 		}
# 	}

# 	// Check region constraints
# 	int region_size = sqrt(A.size());
# 	for (int I=0; I < region_size; ++I) {
# 		for (int J=0; J<region_size; ++J) {
# 			vector<bool> is_present(A.size() + 1, false);
# 			for (int i=0; i<region_size; ++i) {
# 				for (int j=0; j<region_size; ++j){
# 					if (A[region_size * I + i] [region_size * J + j] !=0 &&
# 							is_present[A[region_size * I + i][region_size *J + j ]]){
# 						return false;
# 					} else{
# 						is_present[A[region_size * I + i] [region_size * J + j]] = true;
# 					}
# 				}
# 			}
# 		}
# 	}
# 	return true;
# }


# ------------------
# ### 6.22
# ### Advanced string processing algorithms often use hash tables and dynamic programming.
# ### PHONE NUMBBR MNEMONIC
# - Question on page 71, answer on page 205
# - Problem 6.22: Given a cell phone keypad (specified by a mapping M that takes
# - individual digits and returns the corresponding set of characters) and a number sequence,
# - return all possible character sequences (not just legal words) that correspond
# - to the number sequence. pg. 205
# ------------------

# In[19]:

M={'1':['A','B','C'], '2':['D','E','F'], '3':['G','H','I'], '4':['J','K','L'], '5':['M','N','O'], '6':['P','Q','R'], '7':['S','T'],'8':['U','V'],'9':['W','X'],'0':['Y','Z']}
def allPossibleWords(NumberSeq,M):
	preLL = []
	newLL = []
	for digit in NumberSeq:
		if len(preLL)==0:
			preLL = M[digit]
		else:
			for item in M[digit]:
				for soFarItem in preLL:
					newLL.append(soFarItem + item)
			preLL = newLL
			newLL = []
	return (preLL)
print(allPossibleWords('12',M))
print(allPossibleWords('1',M))
print(allPossibleWords('231',M))

#const array<string, 10> M={"0", "1", "ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ"};

#void phone_mnemonic_helper(const string &num, const int &d, string &ans){
#	if (d == num.size()){
#		cout<<ans << endl;
#	} else {
#		for (const char &c: M[num[d] - '0']){
#			ans[d] = c;
#			phone_mnemonic_helper(num, d+1, ans);
#		}
#	}
#}

#void phone_mnemonic (const string &num){
#	string ans(num.size(), 0);
#	phone_mnemonic_helper(num, 0, ans);
#}
		


# -----------------------------------------------------------------------------------------
# ### 7.1: Linked List
# ### MERGB TWO SORTBD LISTS
# - Question on page 74
# - Answer on page 207
# ### Problem 7.1: Write a function that takes L and F, and returns the merge of L and
# - F. Your code should use O(1) additional storage-it should reuse the nodes from
# - the lists provided as input. Your function should use O(1) additional storage, as
# - illustrated in Figure 7.3.The only field you can change in a node is next.
# -----------------------------------------------------------------------------------------

# In[20]:

# Linked list codes
# template <typename T>
# class note_t {
# 	public:
# 		T data;
# 		shared_ptr<node_t<T>> next;
# }
class Node(object):
    def __init__(self, data=None, next_node=None):
        self.data = data
        self.next_node = next_node
    def get_data(self):
        return self.data
    def get_next(self):
        return self.next_node
    def set_next(self, new_next):
        self.next_node = new_next

class LinkedList(object):
    def __init__(self, head=None):
        self.head = head
	def insert(self, data):
		new_node = Node(data)
		new_node.set_next(self.head)
		self.head = new_node
	def size(self):
		current = self.head
		count = 0
		while current:
			count += 1
			current = current.get_next()
		return count
	def search(self, data):
		current = self.head
		found = False
		while current and found is False:
			if current.get_data() == data:
				found = True
			else:
				current = current.get_next()
		if current is None:
			raise ValueError("Data not in list")
		return current
	def delete(self, data):
		current = self.head
		previous = None
		found = False
		while current and found is False:
			if current.get_data() == data:
				found = True
			else:
				previous = current
				current = current.get_next()
		if current is None:
			raise ValueError("Data not in list")
		if previous is None:
			self.head = current.get_next()
		else:
			previous.set_next(current.get_next())

# my answer to this question
class Node(object):
    def __init__(self, data=None, next_node=None):
        self.data = data
        self.next_node = next_node
    def get_data(self):
        return self.data
    def get_next(self):
        return self.next_node
    def set_next(self, new_next):
        self.next_node = new_next
def mergeLinkedList(L,F):
	curNodeNew = None
	# first set the head
	if F.get_data() > L.get_data():
		newHead = L
		L = L.get_next()
	else:
		newHead = F	
		F = F.get_next()
	curNodeNew = newHead
	while L and F:
		print(F.get_data())
		print(L.get_data())
		if F.get_data() > L.get_data():
			curNodeNew.set_next(L)
			curNodeNew = curNodeNew.get_next()
			L = L.get_next()
		else:
			curNodeNew.set_next(F)
			curNodeNew = curNodeNew.get_next()
			F = F.get_next()
	if L:
		curNodeNew.set_next(L)
	if F:
		curNodeNew.set_next(F)
	return newHead
L = Node(7)
L = Node(5,L)
L = Node(1, L)
F = Node(8)
F = Node(4,F)
F = Node(3,F)
F = Node(2,F)
result = mergeLinkedList(L,F)


# In[21]:

# temple <typename T>
# void append_node(shared_ptr<node_t<T>> &head, shared_ptr<node_t<T>> &tail, shared_ptr<node_t<T>> &n){
# 	head ? tail -> next = n : head = n;
# 	tail = n; // reset tail to the last node
# }

# template <typename T>
# void append_node_and_advance (shared_ptr<node_t<T>> &head, shared_ptr<node_t<T>> &tail, shared_ptr<node_t<T>> &n){
# 	append_node(head, tail, n);
# 	n = n -> next; // advance n
# }

# template <typename T>
# shared_ptr<node_t<T>> merge_sorted_linked_lists (shared_ptr<node_t<T>> F, shared_ptr<node_t<T>> L){
# 	shared_ptr<node_t<T>> sorted_head = nullptr, tail = nullptr;
# 	while (F && L){
# 		append_node_and_advance(sorted_head, tail, F-> data < L-> data ? F : L);
# 	}
# 	// Append the remaining nodes of F
# 	if (F) {
# 		append_node (sorted_head, tail, F)
# 	}
# 	// Append the remaining nodes of L
# 	if (L) {
# 		append_node(sorted_head, tail, L);
# 	}
# 	return sorted_head;
# }


# -----------------------------------------------------------------------------------------
# ### 7.2: CHECKING FOR CYCLICITY
# - Page 74
# - Answer on page pg.208
# ### Problem 7.2: Given a reference to the head of a singly linked list L,how would you
# - determine whether L ends in a null or reaches a cycle of nodes? Write a function
# - that returns null if there does not exist a cycle, and the reference to the start of the
# - cycleif a cycleis present. (You do not know the length of the list in advance.) 
# -----------------------------------------------------------------------------------------

# In[22]:

class Node(object):
	def __init__(self,value=None, next=None):
		self.value = value
		self.next = next
	def get_next(self):
		return self.next
	def get_value(self):
		return self.value
	def set_next(self, next):
		self.next = next
def checkCycle(L):
	seenDic = {}
	while L:
		try:
			seenDic[L] +=1
			return L
		except:
			seenDic[L] = 1
			L = L.get_next()
	return None
L = Node(5)
L = Node(3, L)
N = L
L = Node(6, L)
checkCycle(L)
L.get_next().get_next().get_value()
L.get_next().get_next().set_next(N)
checkCycle(L).get_value()


# - complexity of my approach $\theta(n)$, where n is the number of nodes in the table
# - Other approches:
# 	- to reverse the linked list, O(n), but it changes the data structure
# 	- C like Bit fiddling can be used to set the least significantbit on the next pointer to mark whether a node as been visite (disadvantage of changing data structure)
# 	- O(n^2) double loop, but without extra memory and changing data structure
# - Interesting solution: use slow and fast pointer, move slow by one, and fast by two
# - if both points meet then there is a cycle
# - find the start of the cycle,by first calculating the cyclelength.
# - do this by freezing the fast pointer, and counting the number of timeswe have to advance the slow pointer to come back to the fast pointer
# ### Algorithm:
# ----------
# - we set both slow and fast pointers to the head. 
# - Then we advance fast by the length of the cycle,then move both slow and fast one at a time. 
# - The start of the cycle is located at the node where these two pointers meet again

# In[23]:

#template <typename T>
#shared_ptr<node_t<T>> has_cycle(const shared_ptr<node_t<T>> &head){
#	shared_ptr<node_t<T>> fast = head, slow = head;
#	while (slow && slow -> next && fast && fast ->next && fast->next->next){
#		slow = slow->next, fast = fast->next ->next;
#		// Found cycle
#		if (slow == fast) {
#			// Caculate the cycle length
#			int cycle_len = 0;
#			do {
#				++cycle_len;
#				fast = fast -> next;
#			} while (slow != fast);
#			// Try to find the start of the cycle
#			slow = head, fast = head;
#			// Fast pointer advances cycle_len first
#			while (cycle_len --){
#				fast = fast->next;
#			}
#			// Both pointers advance at the same time
#			while (slow !=fast) {
#				slow = slow -> next, fast = fast -> next;
#			}
#			return slow;	// the start of cycle
#		}
#	}
#	return nullptr; // no cycle
#}


# In[24]:

def has_cycle(head):
	slow = head
	fast = head
	while slow and slow.get_next() and fast and fast.get_next() and fast.get_next().get_next():
		# go ahead one step
		slow = slow.get_next()
		# go ahead two steps
		fast = fast.get_next().get_next()
		if slow == fast:
			# compute the cycle length
			cycle_len = 0
			while slow!= fast:
				cycle_len += 1
				fast = fast.get_next()
			# try to find the start of the cycle
			slow = head
			fast = head
			while cycle_len:
				cycle_len -= 1
				fast = fast.get_next()
			# Both pointers advance at the same time
			while slow!=fast:
				slow=slow.get_next()
				fast=fast.get_next()
			return slow
	return None
L = Node(5)
L = Node(3, L)
N = L
L = Node(6, L)
has_cycle(L)
L.get_next().get_next().get_value()
L.get_next().get_next().set_next(N)
has_cycle(L)


# ------------------
# ### 7.4: OvBRLAPPING LISTS-NO LISTSKAVECYCL
# - desirable from the perspective of reducing memory footprint, as in the flyweight pattern, 
# -	or maintaining a canonical form.
# - Question on page 75
# ### Problem 7.4: Let hl and h2 be the heads of lists Ll and U, respectively. Assume
# - that Ll and L2 are well-formed, that is each consists of a finite sequence of nodes. (In
# - particular, neither list has a cycle.) How would you determine if there exists a node
# - r reachable from both hl and h2 by following the next fields? If such a node exists,
# - find the node that appears earliest when traversing the lists. You are constrained to
# - use no more than constant additional storage. pg. 211
# ------------------	

# In[ ]:

# my solution: brute force
def repeatedNode(h1, h2):
	cur1 = h1
	cur2 = h2
	while cur2!=None:
		cur1 = h1
		while cur1!=None:
			if cur1 == cur2:
				return cur1
			cur1 = cur1.get_next()
	cur2 = cur2.get_next()		
L = Node(5)
L = Node(3, L)
N = L
L = Node(6, L)
L = Node(7, L)
L2 = Node(7)
L2 = Node(8,L2)
L2 = Node(9,N)
repeatedNode(L, L2).get_value()








