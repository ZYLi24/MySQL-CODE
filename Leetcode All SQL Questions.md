### Q175

SELECT<br> 
    p.FirstName,<br>
    p.LastName,<br>
    a.City,<br>
    a.State<br>
FROM Person p<br>
Left Join Address a <br>
USING (PersonID)<br>

### Q176

SELECT (<br>
     SELECT DISTINCT Salary<br>
     FROM Employee<br>
     ORDER BY Salary DESC<br>
     LIMIT 1, 1<br>
) AS SecondHighestSalary<br>

### Q177

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT<br>
BEGIN<br>
  
  DECLARE num INT;<br>
  SET num = N-1;<br>
  
  RETURN(<br>
     SELECT DISTINCT Salary<br>
     FROM Employee<br>
     ORDER BY Salary DESC<br>
     LIMIT num,1<br>
  );<br>
  
END<br>

### Q178

SELECT<br>
    Score,<br>
    DENSE_RANK() OVER (ORDER BY Score DESC) AS 'Rank'<br>
FROM Scores<br>

### Q180

SELECT DISTINCT l1.Num AS ConsecutiveNums<br>
From Logs l1<br>
Join Logs l2<br>
Join Logs l3<br>
ON l1.Id = l2.Id - 1 AND l1.Id = l3.Id - 2<br>
WHERE l1.Num = l2.Num AND l1.Num = l3.Num<br>
