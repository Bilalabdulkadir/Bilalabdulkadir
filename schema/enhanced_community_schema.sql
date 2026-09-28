-- ============================================================================
-- MSc Artificial Intelligence Community Platform - Enhanced Schema
-- ============================================================================
-- Host: fairly-large-locust-7aa7ddd.use2.pgedge.cloud
-- Database: bilalai
-- Connection: postgresql://app:YOUR_PASSWORD@fairly-large-locust-7aa7ddd.use2.pgedge.cloud:5432/bilalai?sslmode=require
-- ============================================================================

-- =========================
-- ROLES & PERMISSIONS
-- =========================

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO roles(name, description)
VALUES
('student', 'MSc AI student'),
('admin', 'Platform administrator'),
('lecturer', 'Course lecturer/instructor'),
('alumni', 'Alumni member');

-- =========================
-- STUDENTS (Enhanced)
-- =========================

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    student_number VARCHAR(50) UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    profile_photo_url TEXT,
    linkedin_url TEXT,
    github_url TEXT,
    twitter_url TEXT,
    bio TEXT,
    graduation_year INTEGER,
    role_id INTEGER REFERENCES roles(id) DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- INTERESTS & EXPERTISE
-- =========================

CREATE TABLE interests (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

INSERT INTO interests(name, description)
VALUES
('Machine Learning', 'Traditional ML algorithms and models'),
('Deep Learning', 'Neural networks and deep architectures'),
('Natural Language Processing', 'NLP, LLMs, text analysis'),
('Computer Vision', 'Image processing, object detection, segmentation'),
('Generative AI', 'GANs, diffusion models, generative models'),
('Agentic AI', 'AI agents and autonomous systems'),
('AI Ethics', 'Fairness, bias, responsible AI'),
('MLOps', 'ML operations, deployment, monitoring'),
('Cloud AI', 'Cloud platforms and AI services'),
('Data Science', 'Data analysis and statistics'),
('Reinforcement Learning', 'RL and decision-making'),
('Knowledge Graphs', 'Semantic networks and knowledge representation'),
('AI Safety', 'Alignment and safety research');

CREATE TABLE student_interests (
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    interest_id INTEGER REFERENCES interests(id) ON DELETE CASCADE,
    PRIMARY KEY (student_id, interest_id)
);

-- =========================
-- TECHNOLOGIES
-- =========================

CREATE TABLE technologies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    category VARCHAR(50),
    documentation_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO technologies(name, category)
VALUES
('Python', 'Language'),
('PyTorch', 'Framework'),
('TensorFlow', 'Framework'),
('JAX', 'Framework'),
('Hugging Face', 'Framework'),
('scikit-learn', 'Library'),
('pandas', 'Library'),
('NumPy', 'Library'),
('OpenAI API', 'Service'),
('Azure AI', 'Service'),
('Google Cloud AI', 'Service'),
('AWS SageMaker', 'Service'),
('PostgreSQL', 'Database'),
('MongoDB', 'Database'),
('Vector DB', 'Database'),
('Docker', 'DevOps'),
('Kubernetes', 'DevOps'),
('Git', 'VCS'),
('Jupyter Notebook', 'Tool'),
('VSCode', 'IDE');

-- =========================
-- EVENTS (Enhanced)
-- =========================

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    event_type VARCHAR(50),
    location VARCHAR(255),
    event_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP,
    max_capacity INTEGER,
    meeting_link TEXT,
    status VARCHAR(30) DEFAULT 'scheduled',
    is_virtual BOOLEAN DEFAULT FALSE,
    created_by INTEGER REFERENCES students(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE event_registrations (
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    event_id INTEGER REFERENCES events(id) ON DELETE CASCADE,
    attended BOOLEAN DEFAULT FALSE,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(student_id, event_id)
);

-- =========================
-- RESOURCES (Enhanced)
-- =========================

CREATE TABLE resource_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

INSERT INTO resource_categories(name, description)
VALUES
('Research Papers', 'Academic papers and preprints'),
('Lecture Notes', 'Course materials and notes'),
('Books', 'Textbooks and educational books'),
('Tutorials', 'Step-by-step guides and tutorials'),
('Datasets', 'Open datasets for projects'),
('Career Resources', 'Job opportunities, CV tips, interview prep'),
('Code Snippets', 'Reusable code examples'),
('Tools & Documentation', 'Software and documentation links');

CREATE TABLE resources (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    resource_type VARCHAR(50),
    category_id INTEGER REFERENCES resource_categories(id),
    url TEXT NOT NULL,
    uploaded_by INTEGER REFERENCES students(id),
    file_size INTEGER,
    download_count INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- DISCUSSION FORUM
-- =========================

CREATE TABLE discussion_posts (
    id SERIAL PRIMARY KEY,
    author_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    is_pinned BOOLEAN DEFAULT FALSE,
    view_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    search_vector tsvector
);

CREATE INDEX idx_post_search ON discussion_posts USING GIN(search_vector);
CREATE INDEX idx_post_created ON discussion_posts(created_at DESC);

CREATE TABLE discussion_comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES discussion_posts(id) ON DELETE CASCADE,
    author_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    comment_text TEXT NOT NULL,
    is_helpful BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_comment_post ON discussion_comments(post_id);

-- =========================
-- PROJECT SHOWCASE
-- =========================

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    short_description VARCHAR(500),
    github_url TEXT,
    demo_url TEXT,
    presentation_url TEXT,
    status VARCHAR(50) DEFAULT 'in_progress',
    visibility VARCHAR(20) DEFAULT 'public',
    owner_id INTEGER REFERENCES students(id),
    start_date DATE,
    end_date DATE,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE project_members (
    project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    role VARCHAR(50) DEFAULT 'contributor',
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(project_id, student_id)
);

CREATE TABLE project_technologies (
    project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
    technology_id INTEGER REFERENCES technologies(id) ON DELETE CASCADE,
    PRIMARY KEY(project_id, technology_id)
);

-- =========================
-- MENTORING
-- =========================

CREATE TABLE mentors (
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    expertise TEXT,
    bio TEXT,
    max_mentees INTEGER DEFAULT 5,
    is_available BOOLEAN DEFAULT TRUE,
    hourly_rate DECIMAL(5, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mentoring_requests (
    id SERIAL PRIMARY KEY,
    mentor_id INTEGER REFERENCES mentors(id) ON DELETE CASCADE,
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    topic TEXT,
    status VARCHAR(50) DEFAULT 'pending',
    message TEXT,
    scheduled_date TIMESTAMP,
    meeting_link TEXT,
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP
);

-- =========================
-- PUBLICATIONS & RESEARCH
-- =========================

CREATE TABLE publications (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    abstract TEXT,
    author_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    co_authors TEXT,
    publication_type VARCHAR(50),
    publication_venue TEXT,
    publication_year INTEGER,
    publication_url TEXT,
    doi TEXT,
    citations_count INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dissertations (
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    abstract TEXT,
    supervisor_id INTEGER REFERENCES students(id),
    submission_date DATE,
    grade VARCHAR(10),
    pdf_url TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- ANNOUNCEMENTS
-- =========================

CREATE TABLE announcements (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    posted_by INTEGER REFERENCES students(id),
    importance_level VARCHAR(20) DEFAULT 'normal',
    is_pinned BOOLEAN DEFAULT FALSE,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP
);

-- =========================
-- NOTIFICATIONS
-- =========================

CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    notification_type VARCHAR(50),
    related_entity_type VARCHAR(50),
    related_entity_id INTEGER,
    is_read BOOLEAN DEFAULT FALSE,
    action_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_notification_user ON notifications(user_id, is_read);

-- =========================
-- SURVEYS & FEEDBACK
-- =========================

CREATE TABLE surveys (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_by INTEGER REFERENCES students(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    closes_at TIMESTAMP
);

CREATE TABLE survey_questions (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50),
    options JSONB,
    order_index INTEGER
);

CREATE TABLE survey_responses (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    question_id INTEGER REFERENCES survey_questions(id),
    response_value TEXT,
    response_data JSONB,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- ACTIVITY LOG (Audit Trail)
-- =========================

CREATE TABLE activity_log (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES students(id),
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INTEGER,
    old_value TEXT,
    new_value TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- KNOWLEDGE BASE (RAG Support)
-- =========================

-- Uncomment if pgvector extension is enabled
-- CREATE EXTENSION IF NOT EXISTS vector;

-- CREATE TABLE knowledge_base (
--     id SERIAL PRIMARY KEY,
--     title TEXT NOT NULL,
--     content TEXT NOT NULL,
--     source VARCHAR(255),
--     embedding VECTOR(1536),
--     document_type VARCHAR(50),
--     created_by INTEGER REFERENCES students(id),
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- CREATE INDEX idx_knowledge_embedding ON knowledge_base USING ivfflat(embedding vector_cosine_ops)
-- WITH (lists = 100);

-- =========================
-- VIEWS & ANALYTICS
-- =========================

CREATE VIEW community_dashboard AS
SELECT
    (SELECT COUNT(*) FROM students WHERE is_active = TRUE) AS total_active_students,
    (SELECT COUNT(*) FROM students WHERE role_id = 2) AS total_lecturers,
    (SELECT COUNT(*) FROM events) AS total_events,
    (SELECT COUNT(*) FROM resources) AS total_resources,
    (SELECT COUNT(*) FROM projects) AS total_projects,
    (SELECT COUNT(*) FROM discussion_posts) AS total_posts,
    (SELECT COUNT(DISTINCT student_id) FROM project_members) AS students_with_projects,
    (SELECT COUNT(*) FROM publications) AS total_publications,
    NOW() AS last_updated;

CREATE VIEW student_profile_completeness AS
SELECT
    s.id,
    s.full_name,
    s.email,
    COUNT(CASE WHEN si.student_id IS NOT NULL THEN 1 END) > 0 AS has_interests,
    s.github_url IS NOT NULL AS has_github,
    s.linkedin_url IS NOT NULL AS has_linkedin,
    s.bio IS NOT NULL AND LENGTH(s.bio) > 20 AS has_complete_bio,
    (COUNT(CASE WHEN si.student_id IS NOT NULL THEN 1 END) > 0)::int +
    (s.github_url IS NOT NULL)::int +
    (s.linkedin_url IS NOT NULL)::int +
    (s.bio IS NOT NULL AND LENGTH(s.bio) > 20)::int AS completeness_score
FROM students s
LEFT JOIN student_interests si ON s.id = si.student_id
GROUP BY s.id, s.full_name, s.email, s.github_url, s.linkedin_url, s.bio;

CREATE VIEW project_statistics AS
SELECT
    p.id,
    p.title,
    p.owner_id,
    COUNT(DISTINCT pm.student_id) AS team_size,
    COUNT(DISTINCT pt.technology_id) AS technologies_used,
    (SELECT COUNT(*) FROM project_members WHERE project_id = p.id) AS contributor_count
FROM projects p
LEFT JOIN project_members pm ON p.id = pm.project_id
LEFT JOIN project_technologies pt ON p.id = pt.project_id
GROUP BY p.id, p.title, p.owner_id;

CREATE VIEW engagement_metrics AS
SELECT
    s.id,
    s.full_name,
    COUNT(DISTINCT dc.id) AS discussion_comments,
    COUNT(DISTINCT dp.id) AS discussion_posts,
    COUNT(DISTINCT pm.project_id) AS projects_joined,
    COUNT(DISTINCT er.event_id) AS events_attended,
    COUNT(DISTINCT r.id) AS resources_shared,
    COUNT(DISTINCT pub.id) AS publications
FROM students s
LEFT JOIN discussion_comments dc ON s.id = dc.author_id
LEFT JOIN discussion_posts dp ON s.id = dp.author_id
LEFT JOIN project_members pm ON s.id = pm.student_id
LEFT JOIN event_registrations er ON s.id = er.student_id AND er.attended = TRUE
LEFT JOIN resources r ON s.id = r.uploaded_by
LEFT JOIN publications pub ON s.id = pub.author_id
GROUP BY s.id, s.full_name
ORDER BY (COUNT(DISTINCT dc.id) + COUNT(DISTINCT dp.id) + COUNT(DISTINCT pm.project_id)) DESC;

-- =========================
-- INDEXES FOR PERFORMANCE
-- =========================

CREATE INDEX idx_students_email ON students(email);
CREATE INDEX idx_students_role ON students(role_id);
CREATE INDEX idx_students_active ON students(is_active);
CREATE INDEX idx_events_date ON events(event_date DESC);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_resources_category ON resources(category_id);
CREATE INDEX idx_resources_featured ON resources(is_featured);
CREATE INDEX idx_projects_owner ON projects(owner_id);
CREATE INDEX idx_projects_featured ON projects(is_featured);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_publications_author ON publications(author_id);
CREATE INDEX idx_mentors_available ON mentors(is_available);
CREATE INDEX idx_announcements_pinned ON announcements(is_pinned);
CREATE INDEX idx_activity_user_date ON activity_log(user_id, created_at DESC);

-- =========================
-- SUMMARY
-- =========================
-- Schema Version: 2.0 - Enhanced for MSc AI Community
-- Total Tables: 26
-- Total Views: 4
-- Key Features:
--   ✓ Role-based access control
--   ✓ Enhanced event management
--   ✓ Resource categorization
--   ✓ Project technology tracking
--   ✓ Research/publication support
--   ✓ Mentoring system
--   ✓ Notification system
--   ✓ Activity logging
--   ✓ Full-text search ready
--   ✓ Vector search ready (when pgvector enabled)
--   ✓ Analytics dashboards
-- =========================
