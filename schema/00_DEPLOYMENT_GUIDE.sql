-- ============================================================================
-- MSc AI Community Platform - Deployment & Verification Guide
-- ============================================================================
-- This guide ensures safe deployment and verification of the schema
-- Run BEFORE and AFTER executing seed data
-- ============================================================================

-- =========================
-- STEP 0: PRE-DEPLOYMENT CHECKLIST
-- =========================
-- Run these verification queries BEFORE loading seed data
-- All should return results with the expected counts

-- 1. Verify Roles Table Exists and Has Expected Roles
SELECT 'STEP 0.1: Check Roles' AS step;
SELECT id, name FROM roles ORDER BY id;
-- Expected output:
-- id | name
-- 1  | student
-- 2  | lecturer
-- 3  | admin
-- 4  | alumni

-- 2. Verify Interests Table Exists and Has All 13 Interests
SELECT 'STEP 0.2: Check Interests' AS step;
SELECT COUNT(*) as total_interests FROM interests;
-- Expected: 13

-- 3. Verify Technologies Table Has All 20 Technologies
SELECT 'STEP 0.3: Check Technologies' AS step;
SELECT COUNT(*) as total_technologies FROM technologies;
-- Expected: 20

-- 4. Verify Resource Categories Has All 8 Categories
SELECT 'STEP 0.4: Check Resource Categories' AS step;
SELECT COUNT(*) as total_categories FROM resource_categories;
-- Expected: 8

-- 5. List All Resource Categories by ID (for verification)
SELECT 'STEP 0.5: Resource Categories by ID' AS step;
SELECT id, name FROM resource_categories ORDER BY id;
-- Expected output:
-- id | name
-- 1  | Research Papers
-- 2  | Lecture Notes
-- 3  | Books
-- 4  | Tutorials
-- 5  | Datasets
-- 6  | Career Resources
-- 7  | Code Snippets
-- 8  | Tools & Documentation

-- 6. List All Interests by ID (for verification)
SELECT 'STEP 0.6: Interests by ID' AS step;
SELECT id, name FROM interests ORDER BY id;
-- Expected: 13 rows starting with Machine Learning (1) through AI Safety (13)

-- 7. List All Technologies by ID (for verification)
SELECT 'STEP 0.7: Technologies by ID' AS step;
SELECT id, name, category FROM technologies ORDER BY id;
-- Verify: Python=1, PyTorch=2, TensorFlow=3, JAX=4, Hugging Face=5, etc.

-- =========================
-- STEP 1: VERIFY ENUM/CHECK CONSTRAINTS
-- =========================
-- Check what values are allowed for key columns

-- 1. Event Status Values (verify 'scheduled' is allowed)
SELECT 'STEP 1.1: Check Event Status Constraint' AS step;
-- Query to check constraint:
SELECT constraint_name, check_clause
FROM information_schema.check_constraints
WHERE table_name = 'events' AND constraint_name LIKE '%status%';

-- 2. Event Type Values
SELECT 'STEP 1.2: Check Event Type' AS step;
-- Example event_types we'll use: 'seminar', 'showcase', 'workshop', 'networking', 'study_group'
-- Verify these are allowed

-- 3. Resource Type Values
SELECT 'STEP 1.3: Check Resource Type' AS step;
-- Example resource_types: 'tutorial', 'research_paper', 'book', 'dataset', 'guide', 'documentation'
-- Verify these are allowed

-- 4. Project Status Values
SELECT 'STEP 1.4: Check Project Status' AS step;
-- Example statuses: 'planning', 'in_progress', 'completed', 'on_hold'
-- Verify these are allowed

-- 5. Project Member Role Values
SELECT 'STEP 1.5: Check Project Member Roles' AS step;
-- Example roles: 'owner', 'contributor', 'advisor'
-- Verify these are allowed

-- 6. Mentoring Status Values
SELECT 'STEP 1.6: Check Mentoring Request Status' AS step;
-- Example statuses: 'pending', 'accepted', 'rejected', 'completed'
-- Verify these are allowed

-- 7. Announcement Importance Levels
SELECT 'STEP 1.7: Check Announcement Importance' AS step;
-- Example levels: 'high', 'normal'
-- Verify these are allowed (may also need: 'critical', 'low')

-- =========================
-- STEP 2: VERIFY FOREIGN KEY RELATIONSHIPS
-- =========================
-- These queries verify all lookup values exist before seeding

-- 1. Check students table can reference roles
SELECT 'STEP 2.1: Verify All Roles Exist' AS step;
SELECT name, COUNT(*) as count
FROM roles
WHERE name IN ('student', 'lecturer', 'admin', 'alumni')
GROUP BY name;
-- Expected: 4 rows, all with count = 1

-- 2. Verify interests exist for all references
SELECT 'STEP 2.2: Verify Interest References' AS step;
SELECT name, id FROM interests WHERE name IN (
    'Machine Learning',
    'Deep Learning',
    'Natural Language Processing',
    'Computer Vision',
    'Generative AI',
    'Agentic AI',
    'AI Ethics',
    'MLOps',
    'Cloud AI',
    'Data Science',
    'Reinforcement Learning',
    'Knowledge Graphs',
    'AI Safety'
) ORDER BY id;
-- Expected: 13 rows

-- 3. Verify technologies exist for all references
SELECT 'STEP 2.3: Verify Technology References' AS step;
SELECT name, id FROM technologies WHERE name IN (
    'Python',
    'PyTorch',
    'TensorFlow',
    'JAX',
    'Hugging Face',
    'scikit-learn',
    'pandas',
    'NumPy',
    'OpenAI API',
    'Azure AI',
    'Google Cloud AI',
    'AWS SageMaker',
    'PostgreSQL',
    'MongoDB',
    'Vector DB',
    'Docker',
    'Kubernetes',
    'Git',
    'Jupyter Notebook',
    'VSCode'
) ORDER BY id;
-- Expected: 20 rows

-- 4. Verify resource categories exist
SELECT 'STEP 2.4: Verify Resource Category References' AS step;
SELECT name, id FROM resource_categories WHERE name IN (
    'Research Papers',
    'Lecture Notes',
    'Books',
    'Tutorials',
    'Datasets',
    'Career Resources',
    'Code Snippets',
    'Tools & Documentation'
) ORDER BY id;
-- Expected: 8 rows

-- =========================
-- STEP 3: EXECUTE SEED DATA
-- =========================
-- Only proceed if STEPS 0-2 passed without errors
-- Run: psql -f 02_seed_data_safe.sql
-- The script uses subqueries, so it should be safe if steps 0-2 passed

-- =========================
-- STEP 4: POST-LOAD VALIDATION
-- =========================
-- Run these AFTER seed data loads successfully

-- 1. Count total records in key tables
SELECT 'STEP 4.1: Record Counts' AS step;
SELECT 'students' AS table_name, COUNT(*) AS records FROM students
UNION ALL
SELECT 'events', COUNT(*) FROM events
UNION ALL
SELECT 'event_registrations', COUNT(*) FROM event_registrations
UNION ALL
SELECT 'resources', COUNT(*) FROM resources
UNION ALL
SELECT 'projects', COUNT(*) FROM projects
UNION ALL
SELECT 'project_members', COUNT(*) FROM project_members
UNION ALL
SELECT 'project_technologies', COUNT(*) FROM project_technologies
UNION ALL
SELECT 'discussion_posts', COUNT(*) FROM discussion_posts
UNION ALL
SELECT 'discussion_comments', COUNT(*) FROM discussion_comments
UNION ALL
SELECT 'student_interests', COUNT(*) FROM student_interests
UNION ALL
SELECT 'mentors', COUNT(*) FROM mentors
UNION ALL
SELECT 'mentoring_requests', COUNT(*) FROM mentoring_requests
UNION ALL
SELECT 'announcements', COUNT(*) FROM announcements
UNION ALL
SELECT 'publications', COUNT(*) FROM publications
UNION ALL
SELECT 'surveys', COUNT(*) FROM surveys
ORDER BY table_name;

-- Expected record counts:
-- announcements             4
-- discussion_comments      10
-- discussion_posts          7
-- event_registrations      12
-- events                    5
-- mentoring_requests        3
-- mentors                   4
-- project_members          15
-- project_technologies     21
-- projects                  6
-- publications              2
-- resources                10
-- student_interests        13
-- students                  8
-- surveys                   2

-- 2. Verify Community Dashboard View Works
SELECT 'STEP 4.2: Community Dashboard' AS step;
SELECT * FROM community_dashboard;

-- 3. Verify Engagement Metrics View Works
SELECT 'STEP 4.3: Engagement Metrics (Top 5)' AS step;
SELECT * FROM engagement_metrics LIMIT 5;

-- 4. Verify Student Profile Completeness View
SELECT 'STEP 4.4: Student Profile Completeness' AS step;
SELECT 
    full_name,
    has_interests,
    has_github,
    has_linkedin,
    has_complete_bio,
    completeness_score
FROM student_profile_completeness
ORDER BY completeness_score DESC;

-- 5. Verify Project Statistics View
SELECT 'STEP 4.5: Project Statistics' AS step;
SELECT * FROM project_statistics;

-- =========================
-- STEP 5: DATA INTEGRITY CHECKS
-- =========================

-- 1. Check for orphaned records (shouldn't be any)
SELECT 'STEP 5.1: Check Orphaned Student Interests' AS step;
SELECT COUNT(*) as orphaned_count
FROM student_interests si
WHERE si.student_id NOT IN (SELECT id FROM students)
   OR si.interest_id NOT IN (SELECT id FROM interests);
-- Expected: 0

-- 2. Check for orphaned project members
SELECT 'STEP 5.2: Check Orphaned Project Members' AS step;
SELECT COUNT(*) as orphaned_count
FROM project_members pm
WHERE pm.project_id NOT IN (SELECT id FROM projects)
   OR pm.student_id NOT IN (SELECT id FROM students);
-- Expected: 0

-- 3. Check for orphaned project technologies
SELECT 'STEP 5.3: Check Orphaned Project Technologies' AS step;
SELECT COUNT(*) as orphaned_count
FROM project_technologies pt
WHERE pt.project_id NOT IN (SELECT id FROM projects)
   OR pt.technology_id NOT IN (SELECT id FROM technologies);
-- Expected: 0

-- 4. Check for orphaned event registrations
SELECT 'STEP 5.4: Check Orphaned Event Registrations' AS step;
SELECT COUNT(*) as orphaned_count
FROM event_registrations er
WHERE er.student_id NOT IN (SELECT id FROM students)
   OR er.event_id NOT IN (SELECT id FROM events);
-- Expected: 0

-- 5. Check for orphaned discussion comments
SELECT 'STEP 5.5: Check Orphaned Discussion Comments' AS step;
SELECT COUNT(*) as orphaned_count
FROM discussion_comments dc
WHERE dc.post_id NOT IN (SELECT id FROM discussion_posts)
   OR dc.author_id NOT IN (SELECT id FROM students);
-- Expected: 0

-- 6. Verify all foreign key constraints
SELECT 'STEP 5.6: Check All Foreign Keys' AS step;
SELECT
    constraint_name,
    table_name,
    column_name,
    foreign_table_name
FROM information_schema.key_column_usage
WHERE constraint_name LIKE '%fk%' OR constraint_name LIKE '%foreign%'
ORDER BY table_name, constraint_name;

-- =========================
-- STEP 6: SAMPLE QUERIES (Verify Functionality)
-- =========================

-- 1. Upcoming events with registration counts
SELECT 'STEP 6.1: Upcoming Events' AS step;
SELECT
    e.title,
    e.event_date,
    e.location,
    e.max_capacity,
    COUNT(er.student_id) as registrations
FROM events e
LEFT JOIN event_registrations er ON e.id = er.event_id
GROUP BY e.id, e.title, e.event_date, e.location, e.max_capacity
ORDER BY e.event_date;

-- 2. Most popular interests
SELECT 'STEP 6.2: Most Popular Interests' AS step;
SELECT
    i.name,
    COUNT(si.student_id) as member_count
FROM interests i
LEFT JOIN student_interests si ON i.id = si.interest_id
GROUP BY i.id, i.name
ORDER BY member_count DESC;

-- 3. Student engagement ranking
SELECT 'STEP 6.3: Top 5 Engaged Students' AS step;
SELECT * FROM engagement_metrics LIMIT 5;

-- 4. Projects by status
SELECT 'STEP 6.4: Projects by Status' AS step;
SELECT
    status,
    COUNT(*) as count
FROM projects
GROUP BY status
ORDER BY count DESC;

-- 5. Resources by category
SELECT 'STEP 6.5: Resources by Category' AS step;
SELECT
    rc.name,
    COUNT(r.id) as resource_count,
    SUM(r.download_count) as total_downloads
FROM resource_categories rc
LEFT JOIN resources r ON rc.id = r.category_id
GROUP BY rc.id, rc.name
ORDER BY resource_count DESC;

-- 6. Student profiles with complete info
SELECT 'STEP 6.6: Complete Student Profiles' AS step;
SELECT
    s.student_number,
    s.full_name,
    s.email,
    r.name as role,
    COUNT(DISTINCT si.interest_id) as interest_count,
    COUNT(DISTINCT pm.project_id) as project_count
FROM students s
LEFT JOIN roles r ON s.role_id = r.id
LEFT JOIN student_interests si ON s.id = si.student_id
LEFT JOIN project_members pm ON s.id = pm.student_id
GROUP BY s.id, s.student_number, s.full_name, s.email, r.name
ORDER BY s.student_number;

-- =========================
-- STEP 7: TROUBLESHOOTING GUIDE
-- =========================
-- Common errors and solutions:

-- ERROR: "violates foreign key constraint"
-- SOLUTION: Run STEP 2 verification queries to find missing reference
-- Example:
-- SELECT * FROM technologies WHERE name = 'PyTorch';
-- If returns empty, the technology wasn't seeded in the schema

-- ERROR: "duplicate key value violates unique constraint"
-- SOLUTION: Check if data already exists and either:
-- a) DELETE FROM table_name WHERE ...; (if safe)
-- b) Run: TRUNCATE TABLE table_name CASCADE; (if resetting all data)

-- ERROR: "column does not exist"
-- SOLUTION: Schema may have changed. Compare with enhanced_community_schema.sql

-- ERROR: "value violates check constraint"
-- SOLUTION: Used invalid enum value. Check STEP 1 constraints for allowed values.

-- MISSING INDEXES: Performance may be slow
-- Run: CREATE INDEX idx_name ON table_name(column_name);

-- =========================
-- STEP 8: RESET/CLEANUP (If needed)
-- =========================
-- DANGER: These commands DELETE ALL DATA. Use only if resetting.

-- To completely reset (WARNING: DELETES ALL DATA):
-- TRUNCATE TABLE activity_log CASCADE;
-- TRUNCATE TABLE notifications CASCADE;
-- TRUNCATE TABLE survey_responses CASCADE;
-- TRUNCATE TABLE survey_questions CASCADE;
-- TRUNCATE TABLE surveys CASCADE;
-- TRUNCATE TABLE mentoring_requests CASCADE;
-- TRUNCATE TABLE mentors CASCADE;
-- TRUNCATE TABLE publications CASCADE;
-- TRUNCATE TABLE dissertations CASCADE;
-- TRUNCATE TABLE project_technologies CASCADE;
-- TRUNCATE TABLE project_members CASCADE;
-- TRUNCATE TABLE projects CASCADE;
-- TRUNCATE TABLE discussion_comments CASCADE;
-- TRUNCATE TABLE discussion_posts CASCADE;
-- TRUNCATE TABLE event_registrations CASCADE;
-- TRUNCATE TABLE events CASCADE;
-- TRUNCATE TABLE resources CASCADE;
-- TRUNCATE TABLE student_interests CASCADE;
-- TRUNCATE TABLE students CASCADE;
-- TRUNCATE TABLE announcements CASCADE;
-- TRUNCATE TABLE knowledge_base CASCADE;

-- Then re-run: 01_schema.sql and 02_seed_data_safe.sql

-- =========================
-- DEPLOYMENT CHECKLIST
-- =========================
-- ✓ Run STEP 0: Pre-deployment checks (all pass)
-- ✓ Run STEP 1: Verify constraints (all values allowed)
-- ✓ Run STEP 2: Verify foreign keys (all references exist)
-- ✓ Execute 02_seed_data_safe.sql
-- ✓ Run STEP 4: Post-load validation (all record counts correct)
-- ✓ Run STEP 5: Data integrity checks (all pass, 0 orphaned records)
-- ✓ Run STEP 6: Sample queries (return expected results)
-- ✓ Run STEP 7: Review any errors
-- ✓ Platform is ready for development!

-- ============================================================================
-- END OF DEPLOYMENT GUIDE
-- ============================================================================
