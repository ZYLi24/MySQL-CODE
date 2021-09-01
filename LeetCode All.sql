### 175. Combine Two Tables

SELECT  
    p.FirstName,  
    p.LastName,  
    a.City,  
    a.State  
FROM Person p  
Left Join Address a  
USING (PersonID)  

### 176. Second Highest Salary

SELECT (  
     SELECT DISTINCT Salary  
     FROM Employee  
     ORDER BY Salary DESC  
     LIMIT 1, 1  
) AS SecondHighestSalary  

### 177. Nth Highest Salary

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT  
BEGIN  
  
  DECLARE num INT;  
  SET num = N-1;  
  
  RETURN(  
     SELECT DISTINCT Salary  
     FROM Employee  
     ORDER BY Salary DESC  
     LIMIT num,1  
  );  
  
END  

### 178. Rank Scores

SELECT  
    Score,  
    DENSE_RANK() OVER (ORDER BY Score DESC) AS 'Rank'  
FROM Scores  

### 180. Consecutive Numbers

SELECT DISTINCT l1.Num AS ConsecutiveNums  
From Logs l1  
Join Logs l2  
Join Logs l3  
ON l1.Id = l2.Id - 1 AND l1.Id = l3.Id - 2  
WHERE l1.Num = l2.Num AND l1.Num = l3.Num  

### 181. Employees Earning More Than Their Managers

SELECT e.Name AS Employee  
FROM Employee e  
LEFT JOIN Employee m  
ON e.ManagerId = m.Id  
WHERE e.Salary > m.Salary  

### 182. Duplicate Emails

SELECT Email  
FROM Person  
GROUP BY Email  
HAVING COUNT(Email) > 1  

### 183. Customers Who Never Order

SELECT Name AS Customers  
FROM Customers  
WHERE Id NOT IN (  
    SELECT CustomerId FROM Orders  
)  


SELECT Name AS Customers  
FROM Customers  
WHERE Id NOT IN (  
    SELECT CustomerId FROM Orders  
)  

### 184. Department Highest Salary

SELECT  
    d.Name AS Department,  
    e.Name AS Employee,  
    e.Salary  
FROM Employee e  
JOIN Department d  
ON e.DepartmentId = d.Id  
WHERE e.Salary = (
    SELECT MAX(Salary)  
    FROM Employee  
    GROUP BY DepartmentId  
    HAVING DepartmentId = e.DepartmentId  
)

### 185. Department Top Three Salaries

SELECT
    Department,
    Employee,
    Salary
FROM(
    SELECT 
        d.Name AS Department,
        e.Name AS Employee,
        e.Salary,
        DENSE_RANK() OVER (PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS ranking
    FROM Employee e 
    JOIN Department d 
    ON e.DepartmentId = d.Id
) salary_rank
WHERE ranking < 4
