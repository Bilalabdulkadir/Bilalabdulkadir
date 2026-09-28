-- ============================================================================
-- MSc AI Community Platform - Seed Data Script
-- ============================================================================
-- This script populates the database with sample data for testing
-- Run this AFTER enhanced_community_schema.sql
-- ============================================================================

-- =========================
-- STUDENTS
-- =========================

INSERT INTO students
(student_number, full_name, email, github_url, linkedin_url, bio, graduation_year, role_id)
VALUES
('MSC001', 'Bilal Muhammed', 'bilal2.muhammed@live.uwe.ac.uk', 'https://github.com/Bilalabdulkadir', 'https://linkedin.com/in/bilalabdulkadir', 'MSc AI student passionate about ML and data science. 5+ years IT experience.', 2027, 1),
('MSC002', 'Sarah Ahmed', 'sarah.ahmed@uwe.ac.uk', 'https://github.com/sarahahmed', 'https://linkedin.com/in/sarahahmed', 'Deep learning enthusiast. Interested in Computer Vision and ethical AI.', 2027, 1),
('MSC003', 'Daniel Smith', 'daniel.smith@uwe.ac.uk', 'https://github.com/dsmith', 'https://linkedin.com/in/danielsmith', 'MLOps engineer. Building scalable AI systems.', 2027, 1),
('MSC004', 'Emily Chen', 'emily.chen@uwe.ac.uk', 'https://github.com/emilychen', 'https://linkedin.com/in/emilychen', 'NLP researcher. Working on multilingual models.', 2027, 1),
('MSC005', 'James Brown', 'james.brown@uwe.ac.uk', 'https://github.com/jbrown', 'https://linkedin.com/in/jamesbrown', 'Reinforcement learning specialist. AI safety advocate.', 2027, 1),
('LEC001', 'Dr. Michael Johnson', 'michael.johnson@uwe.ac.uk', 'https://github.com/drjohnson', 'https://linkedin.com/in/michaeljohnson', 'Lecturer in Artificial Intelligence. Research interests: Deep Learning, NLP.', NULL, 2),
('LEC002', 'Dr. Lisa Wong', 'lisa.wong@uwe.ac.uk', 'https://github.com/drwong', 'https://linkedin.com/in/lisawong', 'Lecturer in Machine Learning. Focus: Ethics and fairness in AI.', NULL, 2),
('ADMIN001', 'Admin User', 'admin@uwe.ac.uk', NULL, NULL, 'Platform administrator for UWE MSc AI Community.', NULL, 2);

-- =========================
-- STUDENT INTERESTS
-- =========================

INSERT INTO student_interests (student_id, interest_id)
VALUES
-- Bilal
(1, 1), -- Machine Learning
(1, 2), -- Deep Learning
(1, 8), -- MLOps
-- Sarah
(2, 3), -- Computer Vision
(2, 5), -- Generative AI
(2, 7), -- AI Ethics
-- Daniel
(3, 1), -- Machine Learning
(3, 8), -- MLOps
(3, 4), -- Cloud AI
-- Emily
(4, 4), -- Natural Language Processing (assumed from table)
(4, 5), -- Generative AI
(4, 10), -- Data Science
-- James
(5, 11), -- Reinforcement Learning
(5, 7), -- AI Ethics
(5, 2); -- Deep Learning

-- =========================
-- EVENTS
-- =========================

INSERT INTO events
(title, description, event_type, location, event_date, end_date, max_capacity, is_virtual, created_by, status)
VALUES
(
    'AI Research Seminar: Generative Models Trends',
    'Explore the latest developments in generative AI, including diffusion models and transformer architectures. Industry speakers and interactive Q&A.',
    'seminar',
    'Online',
    NOW() + INTERVAL '7 days',
    NOW() + INTERVAL '7 days' + INTERVAL '2 hours',
    200,
    TRUE,
    6,
    'scheduled'
),
(
    'MSc Dissertation Showcase',
    'Students present their MSc AI projects and dissertations. Get inspired by peer research and network with fellow researchers.',
    'showcase',
    'UWE Bristol - Graduate Center',
    NOW() + INTERVAL '30 days',
    NOW() + INTERVAL '30 days' + INTERVAL '4 hours',
    150,
    FALSE,
    6,
    'scheduled'
),
(
    'MLOps Workshop: Production ML Pipelines',
    'Learn how to deploy, monitor, and maintain machine learning models in production. Hands-on with Docker, Kubernetes, and MLflow.',
    'workshop',
    'Online',
    NOW() + INTERVAL '14 days',
    NOW() + INTERVAL '14 days' + INTERVAL '3 hours',
    100,
    TRUE,
    3,
    'scheduled'
),
(
    'Networking Evening: AI Careers',
    'Meet industry professionals, recruiters, and alumni working in AI/ML. Discuss career paths and opportunities.',
    'networking',
    'UWE Bristol - Student Union',
    NOW() + INTERVAL '21 days',
    NOW() + INTERVAL '21 days' + INTERVAL '2 hours',
    120,
    FALSE,
    1,
    'scheduled'
),
(
    'Deep Learning Study Group Kickoff',
    'Weekly study group for working through deep learning fundamentals. First session: Neural Network Basics.',
    'study_group',
    'Online',
    NOW() + INTERVAL '5 days',
    NOW() + INTERVAL '5 days' + INTERVAL '1 hour 30 minutes',
    50,
    TRUE,
    2,
    'scheduled'
);

-- =========================
-- EVENT REGISTRATIONS
-- =========================

INSERT INTO event_registrations (student_id, event_id, attended)
VALUES
(1, 1, FALSE),
(1, 2, FALSE),
(1, 3, FALSE),
(2, 1, FALSE),
(2, 2, FALSE),
(2, 5, FALSE),
(3, 3, FALSE),
(3, 2, FALSE),
(4, 1, FALSE),
(4, 5, FALSE),
(5, 2, FALSE),
(5, 3, FALSE);

-- =========================
-- RESOURCE CATEGORIES (Already seeded in schema, but adding for reference)
-- =========================

-- Categories already exist from schema

-- =========================
-- RESOURCES
-- =========================

INSERT INTO resources
(title, description, resource_type, category_id, url, uploaded_by, is_featured, download_count)
VALUES
(
    'Introduction to Machine Learning - Complete Guide',
    'Comprehensive tutorial covering supervised learning, unsupervised learning, and model evaluation.',
    'tutorial',
    4,
    'https://example.com/intro-ml',
    1,
    TRUE,
    145
),
(
    'Prompt Engineering Best Practices for LLMs',
    'Guide to crafting effective prompts for ChatGPT, GPT-4, and other large language models.',
    'tutorial',
    4,
    'https://example.com/prompt-engineering',
    1,
    TRUE,
    203
),
(
    'PyTorch Deep Learning Fundamentals',
    'Step-by-step tutorial on building neural networks with PyTorch.',
    'tutorial',
    4,
    'https://example.com/pytorch-tutorial',
    2,
    FALSE,
    89
),
(
    'Computer Vision with OpenCV',
    'Practical guide to image processing and computer vision tasks.',
    'tutorial',
    4,
    'https://example.com/cv-opencv',
    2,
    FALSE,
    112
),
(
    'Attention is All You Need (Transformer Paper)',
    'Seminal paper introducing the Transformer architecture. Read this!',
    'research_paper',
    1,
    'https://arxiv.org/abs/1706.03762',
    7,
    TRUE,
    267
),
(
    'An Introduction to Statistical Learning',
    'Classic textbook covering regression, classification, and other ML fundamentals.',
    'book',
    3,
    'https://www.statlearning.com/',
    7,
    TRUE,
    189
),
(
    'ImageNet Dataset',
    'Large-scale visual database for computer vision research. 14M+ labeled images.',
    'dataset',
    5,
    'https://www.image-net.org/',
    1,
    FALSE,
    73
),
(
    'Career Guide: AI/ML Job Market 2025',
    'Insights into job roles, salary trends, and skills in demand for AI professionals.',
    'guide',
    6,
    'https://example.com/ai-career-guide',
    6,
    TRUE,
    156
),
(
    'LangChain Framework Documentation',
    'Complete guide to building LLM applications with LangChain.',
    'documentation',
    8,
    'https://python.langchain.com/',
    3,
    FALSE,
    98
),
(
    'Ethical AI Principles and Implementation',
    'Practical guide to implementing fairness, transparency, and accountability in AI systems.',
    'guide',
    6,
    'https://example.com/ethical-ai',
    7,
    FALSE,
    67
);

-- =========================
-- PROJECTS
-- =========================

INSERT INTO projects
(title, description, short_description, github_url, demo_url, status, owner_id, start_date, is_featured)
VALUES
(
    'Automated Academic Essay Feedback System',
    'NLP-based system that provides AI-powered feedback on student essays. Uses BERT and GPT for analysis of clarity, structure, grammar, and academic content. Integrated with Moodle LMS.',
    'AI essay feedback generator with detailed NLP analysis',
    'https://github.com/Bilalabdulkadir/essay-feedback-ai',
    'https://essay-feedback-demo.example.com',
    'in_progress',
    1,
    '2025-09-01',
    TRUE
),
(
    'AI Career Assistant Chatbot',
    'Personalized career recommendation chatbot powered by OpenAI GPT-4. Analyzes user skills, interests, and experience to suggest career paths, resources, and job opportunities in the AI/ML industry.',
    'Smart career guidance chatbot for AI professionals',
    'https://github.com/sarahahmed/career-assistant-ai',
    'https://career-assistant.example.com',
    'in_progress',
    2,
    '2025-08-15',
    TRUE
),
(
    'MLOps Pipeline Orchestration Tool',
    'Python framework for automating ML model training, validation, deployment, and monitoring. Integrates with Docker, Kubernetes, and cloud platforms. Includes experiment tracking and model versioning.',
    'Production-ready ML pipeline automation framework',
    'https://github.com/dsmith/mlops-orchestrator',
    'https://mlops-orchestrator-docs.example.com',
    'in_progress',
    3,
    '2025-07-01',
    FALSE
),
(
    'Multilingual Sentiment Analysis Engine',
    'NLP system for detecting sentiment across 15+ languages using transformer models. Supports real-time analysis and custom domain fine-tuning. Built with Hugging Face Transformers.',
    'Cross-lingual sentiment analysis with zero-shot learning',
    'https://github.com/emilychen/multilingual-sentiment',
    'https://sentiment-api.example.com',
    'completed',
    4,
    '2025-06-01',
    FALSE
),
(
    'Deep Reinforcement Learning Game AI',
    'Intelligent game-playing AI agent trained using Deep Q-Networks (DQN) and Policy Gradients. Learns to master complex games from visual input. Includes training framework and visualization tools.',
    'RL-based AI learning to play games from pixels',
    'https://github.com/jbrown/game-ai-rl',
    'https://game-ai-demo.example.com',
    'in_progress',
    5,
    '2025-05-15',
    FALSE
),
(
    'UWE MSc AI Community Platform',
    'Full-stack web application connecting MSc AI students, faculty, and alumni. Features: profiles, event management, discussion forums, project showcase, resource library, and analytics dashboards.',
    'Web platform for MSc AI community engagement',
    'https://github.com/Bilalabdulkadir/msc-ai-community',
    NULL,
    'planning',
    1,
    '2025-09-28',
    TRUE
);

-- =========================
-- PROJECT TECHNOLOGIES
-- =========================

INSERT INTO project_technologies (project_id, technology_id)
VALUES
-- Project 1: Essay Feedback
(1, 1),  -- Python
(1, 5),  -- Hugging Face
(1, 13), -- PostgreSQL
-- Project 2: Career Assistant
(2, 1),  -- Python
(2, 10), -- OpenAI API
(2, 15), -- Vector DB
-- Project 3: MLOps
(3, 1),  -- Python
(3, 16), -- Docker
(3, 17), -- Kubernetes
(3, 13), -- PostgreSQL
-- Project 4: Sentiment Analysis
(4, 1),  -- Python
(4, 5),  -- Hugging Face
(4, 9),  -- OpenAI API
-- Project 5: Game AI
(5, 1),  -- Python
(5, 3),  -- TensorFlow
(5, 4),  -- JAX
-- Project 6: Community Platform
(6, 1),  -- Python
(6, 13), -- PostgreSQL
(6, 16), -- Docker
(6, 18); -- Git

-- =========================
-- PROJECT MEMBERS
-- =========================

INSERT INTO project_members (project_id, student_id, role)
VALUES
(1, 1, 'owner'),
(1, 2, 'contributor'),
(2, 2, 'owner'),
(2, 4, 'contributor'),
(3, 3, 'owner'),
(3, 1, 'contributor'),
(4, 4, 'owner'),
(4, 2, 'advisor'),
(5, 5, 'owner'),
(5, 1, 'contributor'),
(6, 1, 'owner'),
(6, 2, 'contributor'),
(6, 3, 'contributor'),
(6, 4, 'contributor'),
(6, 5, 'contributor');

-- =========================
-- DISCUSSION POSTS
-- =========================

INSERT INTO discussion_posts (author_id, title, content, is_pinned)
VALUES
(1, 'Best Resources for Getting Started with Deep Learning?', 
'Hi everyone! I''m new to deep learning and want to build a solid foundation. What courses, books, and tutorials do you recommend? I''m particularly interested in practical implementations.', 
FALSE),

(2, 'Dissertation Ideas: Computer Vision + Generative AI', 
'Looking for dissertation topic ideas that combine computer vision and generative models. Has anyone worked on image synthesis or style transfer? Would love to hear about challenges and opportunities.',
TRUE),

(3, 'MLOps Best Practices: Model Versioning and Tracking', 
'What tools do you use for tracking model versions and experiments? Currently using MLflow, but curious about alternatives like Weights & Biases and DVC. Pros and cons?',
FALSE),

(4, 'Career Path: Industry vs. Academia', 
'Wondering if anyone has experience transitioning between industry and academic research in AI. What are the key differences and how do you decide which path to take?',
FALSE),

(5, 'AI Safety and Alignment: Critical Research Areas', 
'What do you think are the most important unsolved problems in AI safety and alignment? Any resources or papers you''d recommend for deep dives?',
FALSE),

(1, 'Project Collaboration: Looking for Team Members', 
'I''m starting a project on automated essay feedback using NLP. Looking for 2-3 collaborators interested in working on the backend and deployment. Experience with FastAPI and Docker helpful.',
FALSE),

(3, 'Study Group: Preparing for ML System Design Interviews', 
'Anyone interested in forming a study group to prepare for ML system design interviews? We could meet weekly and work through problems together.',
TRUE);

-- =========================
-- DISCUSSION COMMENTS
-- =========================

INSERT INTO discussion_comments (post_id, author_id, comment_text)
VALUES
(1, 2, 'I recommend starting with "Fast.ai - Practical Deep Learning for Coders". It''s very hands-on and projects-based. Complemented it with "Deep Learning" book by Goodfellow, Bengio, Courville.'),
(1, 6, 'Fast.ai is excellent! Also check out the Stanford CS231n (Convolutional Neural Networks) lecture series. It''s older but the fundamentals are solid.'),

(2, 4, 'I''m working on a similar topic! Would love to collaborate. I''m using DALL-E API and exploring fine-tuning with custom datasets. Let''s chat!'),
(2, 5, 'The main challenge I faced was getting good training data. Consider looking into COCO and Open Images datasets for starting.'),

(3, 1, 'We use Weights & Biases at our company. The integration is seamless and the UI is beautiful. Worth exploring!'),
(3, 3, 'MLflow is solid but sometimes feels clunky. DVC is interesting but requires more manual setup.'),

(4, 7, 'Great question! I spent 5 years in industry before PhD. The main difference: industry values products/deployment, academia values novel theory/insights. Both are rewarding in different ways.'),

(5, 1, 'Check out the Alignment Research Center papers and Stuart Russell''s work on "Human-Compatible AI". Super relevant and thought-provoking.'),

(6, 3, 'Count me in! I''m interested in backend development. Have experience with FastAPI and PostgreSQL. When can we schedule a kickoff meeting?'),
(6, 4, 'I''d like to contribute to this! I have experience with Docker and cloud deployments. Reach out!'),

(7, 2, 'Great idea! I''m preparing for interviews too. Let''s organize. Thinking of meeting every Tuesday evening?');

-- =========================
-- MENTORS
-- =========================

INSERT INTO mentors (student_id, expertise, bio, max_mentees, is_available)
VALUES
(6, 'Deep Learning, Computer Vision, Research Methodology',
'Dr. Johnson leads research in deep learning architectures. 10+ years experience. Happy to mentor on dissertation topics and research design.',
5, TRUE),

(7, 'ML Ethics, Fairness, Responsible AI',
'Dr. Wong specializes in ethical AI systems. Passionate about helping students navigate bias and fairness challenges in their projects.',
4, TRUE),

(3, 'MLOps, Deployment, Cloud Infrastructure',
'Daniel has 3+ years industry experience in ML deployment. Great for practical deployment questions and system design.',
3, TRUE),

(2, 'Computer Vision, Deep Learning Implementation',
'Sarah is strong on CV techniques and has published in the area. Great for detailed technical guidance.',
3, TRUE);

-- =========================
-- MENTORING REQUESTS
-- =========================

INSERT INTO mentoring_requests (mentor_id, student_id, topic, status, message, scheduled_date)
VALUES
(3, 1, 'Help with MLOps for essay feedback project',
'pending',
'Hi Daniel, I''m looking to set up a production ML pipeline for my dissertation project. Would love your guidance on best practices.',
NULL),

(2, 4, 'Computer Vision techniques for my project',
'pending',
'Sarah, I''m working on a CV project and would benefit from your expertise. Hoping to discuss architecture choices.',
NOW() + INTERVAL '3 days' + INTERVAL '14:00:00'),

(1, 3, 'Deep Learning dissertation topic advice',
'accepted',
'Looking for guidance on my dissertation proposal. Dr. Johnson has agreed to mentor.',
NOW() + INTERVAL '5 days' + INTERVAL '10:00:00');

-- =========================
-- ANNOUNCEMENTS
-- =========================

INSERT INTO announcements (title, content, posted_by, importance_level, is_pinned, expires_at)
VALUES
(
    'Welcome to UWE MSc AI Community Platform!',
    'Hello students! Welcome to our new community platform. Here you can connect with peers, share resources, collaborate on projects, and engage in discussions. Please complete your profile and explore all features.',
    8,
    'high',
    TRUE,
    NOW() + INTERVAL '60 days'
),
(
    'Dissertation Submission Deadline Extended',
    'The MSc dissertation submission deadline has been extended to April 30, 2026. Please ensure your work is properly formatted and references are complete.',
    6,
    'high',
    TRUE,
    NOW() + INTERVAL '180 days'
),
(
    'Industry Guest Lecture: "LLMs in Production"',
    'Next Wednesday at 2pm: Industry expert from a major tech company will discuss deploying large language models at scale. Registration link in events.',
    6,
    'normal',
    FALSE,
    NOW() + INTERVAL '7 days'
),
(
    'New Learning Resources Added',
    'Check out our newly curated selection of books, tutorials, and research papers on generative AI and ethical AI. Available in the Resources section.',
    7,
    'normal',
    FALSE,
    NOW() + INTERVAL '30 days'
);

-- =========================
-- PUBLICATIONS
-- =========================

INSERT INTO publications (title, abstract, author_id, publication_type, publication_venue, publication_year, publication_url, citations_count, is_featured)
VALUES
(
    'Efficient Fine-tuning of Large Language Models for Domain-Specific Tasks',
    'We propose a novel approach to fine-tune LLMs efficiently using parameter-efficient techniques. Our method reduces computational overhead by 70% while maintaining performance.',
    6,
    'conference',
    'NeurIPS 2024',
    2024,
    'https://arxiv.org/abs/2401.xxxxx',
    12,
    TRUE
),
(
    'Fairness in Computer Vision: A Comprehensive Survey',
    'A thorough survey of fairness issues in CV systems, including bias detection, mitigation strategies, and evaluation metrics.',
    7,
    'journal',
    'ACM Transactions on AI Research',
    2024,
    'https://example.com/fairness-survey',
    8,
    TRUE
);

-- =========================
-- SURVEYS
-- =========================

INSERT INTO surveys (title, created_by, is_active, closes_at)
VALUES
(
    'MSc AI Program Feedback - Sept 2026',
    6,
    TRUE,
    NOW() + INTERVAL '14 days'
),
(
    'Community Platform Feature Requests',
    8,
    TRUE,
    NOW() + INTERVAL '21 days'
);

-- =========================
-- VERIFICATION QUERIES
-- =========================
-- Run these to verify seed data loaded correctly:

-- Total counts:
-- SELECT 'Students' as entity, COUNT(*) as count FROM students
-- UNION ALL
-- SELECT 'Events', COUNT(*) FROM events
-- UNION ALL
-- SELECT 'Resources', COUNT(*) FROM resources
-- UNION ALL
-- SELECT 'Projects', COUNT(*) FROM projects
-- UNION ALL
-- SELECT 'Discussion Posts', COUNT(*) FROM discussion_posts
-- UNION ALL
-- SELECT 'Discussion Comments', COUNT(*) FROM discussion_comments;

-- Community dashboard:
-- SELECT * FROM community_dashboard;

-- Upcoming events:
-- SELECT title, event_date, location, max_capacity, (SELECT COUNT(*) FROM event_registrations WHERE event_id = events.id) as registrations
-- FROM events
-- ORDER BY event_date;

-- Most popular interests:
-- SELECT i.name, COUNT(*) as members
-- FROM interests i
-- JOIN student_interests si ON i.id = si.interest_id
-- GROUP BY i.name
-- ORDER BY members DESC;

-- Student engagement:
-- SELECT * FROM engagement_metrics
-- LIMIT 5;

-- ============================================================================
-- SEED DATA COMPLETE
-- ============================================================================
-- Total records created:
--   8 Students
--   13 Interests (with associations)
--   5 Events
--   10 Resources
--   6 Projects
--   15 Project Members
--   7 Discussion Posts
--   8 Discussion Comments
--   4 Mentors
--   3 Mentoring Requests
--   4 Announcements
--   2 Publications
--   2 Surveys
-- ============================================================================
