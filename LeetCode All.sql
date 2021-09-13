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

### 196. Delete Duplicate Emails

DELETE p2
FROM Person p1, Person p2
WHERE p1.Email = p2.Email AND p1.Id < p2.Id

197. Rising Temperature

SELECT w1.id
FROM Weather w1, Weather w2
WHERE w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY) AND w1.Temperature > w2.Temperature

262. Trips and Users
    ###Method 1:

WITH comb_trips AS (
    SELECT
        t.Status,
        t.Request_at,
        u1.Banned AS c_banned,
        u2.Banned AS d_banned
    FROM Trips t 
    LEFT JOIN Users u1 
        ON (t.Client_Id = u1.Users_Id  AND u1.Role = 'client')
    LEFT JOIN Users u2 
        ON (t.Driver_Id = u2.Users_Id  AND u2.Role = 'driver')    
)

SELECT 
    Day,
    Cancellation_Rate AS 'Cancellation Rate'
FROM (
    SELECT 
        Request_at AS Day, 
        ROUND(
            (COUNT(
                CASE 
                WHEN Status <> 'completed'
                    AND c_banned = 'No'
                    AND d_banned = 'No'
                THEN Status 
                END) 
            /
            COUNT(
                CASE 
                WHEN c_banned = 'No' AND d_banned = 'No'
                THEN Status 
                END) 
            ),  
        2) AS Cancellation_Rate
    FROM comb_trips 
    GROUP BY Request_at
    HAVING 
        Request_at IN ("2013-10-01", "2013-10-02", "2013-10-03")
        AND Cancellation_Rate IS NOT NULL
) crate

###Method 2 Easier Way:

SELECT 
    t.request_at AS Day, 
	ROUND(
        SUM(
            IF(T.STATUS = 'completed',0,1)
        )
        / 
        COUNT(T.STATUS),
        2
	) AS 'Cancellation Rate'
FROM Trips AS t
JOIN Users AS u1 ON (t.client_id = u1.users_id AND u1.banned ='No')
JOIN Users AS u2 ON (t.driver_id = u2.users_id AND u2.banned ='No')
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at
