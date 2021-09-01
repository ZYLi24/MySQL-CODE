### Q175

SELECT  
    p.FirstName,  
    p.LastName,  
    a.City,  
    a.State  
FROM Person p  
Left Join Address a  
USING (PersonID)  

### Q176

SELECT (  
     SELECT DISTINCT Salary  
     FROM Employee  
     ORDER BY Salary DESC  
     LIMIT 1, 1  
) AS SecondHighestSalary  

### Q177

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

### Q178

SELECT  
    Score,  
    DENSE_RANK() OVER (ORDER BY Score DESC) AS 'Rank'  
FROM Scores  

### Q180

SELECT DISTINCT l1.Num AS ConsecutiveNums  
From Logs l1  
Join Logs l2  
Join Logs l3  
ON l1.Id = l2.Id - 1 AND l1.Id = l3.Id - 2  
WHERE l1.Num = l2.Num AND l1.Num = l3.Num  

### Q181

SELECT e.Name AS Employee  
FROM Employee e  
LEFT JOIN Employee m  
ON e.ManagerId = m.Id  
WHERE e.Salary > m.Salary  

### Q182

SELECT Email  
FROM Person  
GROUP BY Email  
HAVING COUNT(Email) > 1  

### Q183

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

### Q184

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
