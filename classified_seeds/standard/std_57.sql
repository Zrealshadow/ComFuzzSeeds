WITH app_user AS (
    SELECT 'a' AS id, 'organizationId' AS organization_id, 'Africa/Abidjan' AS timezone
),
employee AS (
    SELECT 'a' AS id, 'organizationId' AS organization_id, 'a' AS user_id, 'a' AS manager_id
)
SELECT DISTINCT app_user.id 
FROM app_user 
LEFT OUTER JOIN employee AS employee_1 ON employee_1.user_id = app_user.id 
LEFT OUTER JOIN employee AS manager_employee_1 ON (employee_1.manager_id = manager_employee_1.id AND manager_employee_1.user_id IN (
    SELECT app_user.id 
    FROM app_user 
    WHERE app_user.timezone = 'Africa/Abidjan' AND app_user.organization_id = 'organizationId'
))
LEFT OUTER JOIN employee AS employee_2 ON employee_2.user_id = app_user.id 
LEFT OUTER JOIN employee AS manager_employee_2 ON (employee_2.manager_id = manager_employee_2.id AND manager_employee_2.user_id IN (
    SELECT app_user.id 
    FROM app_user 
    WHERE app_user.timezone = 'Africa/Algiers' AND app_user.organization_id = 'organizationId'
))
LEFT OUTER JOIN employee AS employee_3 ON employee_3.user_id = app_user.id 
LEFT OUTER JOIN employee AS manager_employee_3 ON (employee_3.manager_id = manager_employee_3.id AND manager_employee_3.user_id IN (
    SELECT app_user.id 
    FROM app_user 
    WHERE app_user.timezone = 'Africa/Abidjan' AND app_user.organization_id = 'organizationId'
));
