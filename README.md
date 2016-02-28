== README

This README would normally document whatever steps are necessary to get the
application up and running.



# SQL task

##Given tables:

#Tasks (id, name, status, project_id)
#Projects (id, name)

#Write the queries for:

1) get all statuses, not repeating, alphabetically ordered
```
SELECT DISTINCT status FROM Tasks ORDER BY status ASC;
```

2) get the count of all tasks in each project, order by tasks count descending
```
SELECT COUNT(*) AS count FROM Tasks GROUP BY project_id ORDER BY count DESC;
```

3) get the count of all tasks in each project, order by projects names
```
SELECT COUNT(*) AS count, Projects.name FROM Tasks INNER JOIN Projects ON project_id = Projects.id GROUP BY Projects.name ORDER BY Projects.name ASC;
```

4) get the tasks for all projects having the name beginning with “N” letter
```
SELECT * FROM Tasks WHERE name like 'N%';
```

5) get the list of all projects containing the ‘a’ letter in the middle of the name, 
and show the tasks count near each project. Mention that there can exist projects without tasks and tasks with project_id=NULL
```
SELECT Projects.name, COUNT(Tasks.id) as count FROM Projects RIGHT JOIN Tasks ON Projects.id = project_id WHERE Projects.name LIKE '_%a%_' GROUP BY Projects.name;
```

6) get the list of tasks with duplicate names. Order alphabetically
```
SELECT Tasks.name, Tasks.id FROM Tasks INNER JOIN (SELECT id, name FROM Tasks GROUP BY name HAVING count(id) > 1) dup  ON Tasks.name = dup.name ORDER BY Tasks.name ASC;
```

7) get the list of tasks having several exact matches of both name and status, from the project ‘Garage’. Order by matches count
```
SELECT Tasks.name, Tasks.id, Tasks.status FROM Tasks INNER JOIN (SELECT id, status, name FROM Tasks GROUP BY status HAVING count(id) > 1) dup ON Tasks.status = dup.status WHERE project_id = (SELECT id FROM Projects WHERE name = 'Garage') ORDER BY Tasks.name;
```

8) get the list of project names having more than 10 tasks in status ‘completed’. Order by project_id
```
SELECT Projects.name, COUNT(Tasks.id) as count FROM Projects RIGHT JOIN Tasks ON Projects.id = Tasks.project_id WHERE Tasks.status = 'completed' GROUP BY Projects.name HAVING count > 10 ORDER BY Projects.id;
```
