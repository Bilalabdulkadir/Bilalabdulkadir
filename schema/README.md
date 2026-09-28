# MSc AI Community Platform

A full-stack community platform for UWE Bristol MSc Artificial Intelligence students, lecturers, alumni, and researchers. Connect, collaborate, share knowledge, and build AI projects together.

**Status:** Database schema and seed data ready | Backend/Frontend in development  
**Host:** pgEdge Cloud | **Database:** PostgreSQL 18 | **Repository:** [Bilalabdulkadir/Bilalabdulkadir](https://github.com/Bilalabdulkadir/Bilalabdulkadir)

---

## 🎯 Features

- 👤 **Student Profiles** — Complete profiles with GitHub, LinkedIn, bio, interests
- 💬 **Community Discussions** — Forum for peer learning and Q&A
- 📅 **Event Management** — Seminars, workshops, networking events with registration
- 🛠️ **Project Showcase** — Collaborative projects with technology tracking
- 📚 **Resource Library** — Curated tutorials, papers, datasets, career resources
- 🎓 **Mentoring Program** — Connect mentors with mentees for guidance
- 📝 **Research Publications** — Share dissertations, papers, and academic work
- 📊 **Analytics Dashboards** — Community engagement metrics and insights
- 🔔 **Notification System** — Real-time alerts for events, discussions, and activities
- 🔍 **Full-Text Search** — Find discussions and resources instantly
- 🧠 **Future pgvector/RAG** — Semantic search and AI-powered knowledge retrieval

---

## 🏗️ Architecture

```text
Frontend
├── Next.js 14+
├── Tailwind CSS
└── shadcn/ui

Backend
├── FastAPI 0.100+
├── SQLAlchemy ORM
└── PostgreSQL 18 (pgEdge)

Authentication
├── Auth.js v5+
├── Email login
└── OAuth (GitHub, Google)

Infrastructure
├── pgEdge Cloud (PostgreSQL)
├── Docker (Containerization)
└── GitHub Actions (CI/CD)

AI Features (Future)
├── OpenAI / Azure OpenAI
├── pgvector (Embeddings)
└── LangChain (RAG)
```

---

## 📊 Database Setup

### PostgreSQL Information

```text
Database Name:    bilalai
Platform:         pgEdge Cloud
Host:             fairly-large-locust-7aa7ddd.use2.pgedge.cloud
Port:             5432
User:             app
SSL Mode:         Required
PostgreSQL Ver:   18
```

### Connection String

```bash
postgresql://app:YOUR_PASSWORD@fairly-large-locust-7aa7ddd.use2.pgedge.cloud:5432/bilalai?sslmode=require
```

### Schema Files

```text
schema/
├── 01_enhanced_community_schema.sql    (26 tables, 4 views, 14 indexes)
├── 02_seed_data_safe.sql                (Realistic sample data - 8 students, 6 projects, etc.)
├── 00_DEPLOYMENT_GUIDE.sql              (Pre/post deployment verification)
└── README.md                            (This file)
```

---

## 🚀 Quick Start

### Prerequisites

- PostgreSQL client (psql)
- Git
- Access to pgEdge Cloud (credentials)

### Installation Steps

#### 1. Create Schema

Deploy the core database schema with 26 tables and 4 analytics views:

```bash
PGSSLMODE=require \
PGPASSWORD='YOUR_PASSWORD' \
psql -U app \
     -h fairly-large-locust-7aa7ddd.use2.pgedge.cloud \
     -p 5432 \
     -d bilalai \
     -f schema/01_enhanced_community_schema.sql
```

**Output:** Schema created successfully ✅

#### 2. Load Seed Data

Populate with realistic sample data (8 students, 5 events, 10 resources, 6 projects, etc.):

```bash
PGSSLMODE=require \
PGPASSWORD='YOUR_PASSWORD' \
psql -U app \
     -h fairly-large-locust-7aa7ddd.use2.pgedge.cloud \
     -p 5432 \
     -d bilalai \
     -f schema/02_seed_data_safe.sql
```

**Output:** 
```
SEED DATA LOAD COMPLETE
Students: 8
Events: 5
Resources: 10
Projects: 6
Discussion Posts: 7
```

#### 3. Run Verification

Execute comprehensive pre/post-deployment checks:

```bash
PGSSLMODE=require \
PGPASSWORD='YOUR_PASSWORD' \
psql -U app \
     -h fairly-large-locust-7aa7ddd.use2.pgedge.cloud \
     -p 5432 \
     -d bilalai \
     -f schema/00_DEPLOYMENT_GUIDE.sql
```

**Verification Checklist:**
- ✅ All tables created
- ✅ Foreign key constraints valid
- ✅ Seed data loads without errors
- ✅ Analytics views operational
- ✅ Record counts verified
- ✅ Data integrity checks pass

---

## 📋 Database Schema

### Core Entities (26 Tables)

```text
✅ students                    (8 records - MSc students, lecturers, admin)
✅ roles                        (4 records - student, lecturer, admin, alumni)
✅ interests                   (13 records - ML, CV, NLP, AI Ethics, etc.)
✅ student_interests           (Many-to-many student/interest associations)
✅ events                      (5 records - seminars, workshops, networking)
✅ event_registrations        (12 records - student event attendance)
✅ resources                   (10 records - tutorials, papers, datasets)
✅ resource_categories         (8 categories - research, tutorials, books, etc.)
✅ technologies                (20 records - Python, PyTorch, TensorFlow, etc.)
✅ projects                    (6 records - active/completed projects)
✅ project_members            (15 records - collaborative team membership)
✅ project_technologies       (21 associations - tech stack per project)
✅ discussion_posts           (7 records - community forum threads)
✅ discussion_comments        (10 records - discussion replies)
✅ mentors                    (4 records - expertise areas)
✅ mentoring_requests         (3 records - mentee-mentor connections)
✅ publications               (2 records - dissertations & papers)
✅ dissertations              (Future - MSc thesis tracking)
✅ announcements              (4 records - platform updates)
✅ notifications              (Real-time alerts)
✅ surveys                    (2 records - community feedback)
✅ survey_questions           (Questions per survey)
✅ survey_responses           (Response data per student)
✅ activity_log               (Audit trail)
✅ knowledge_base             (Future - pgvector embeddings for RAG)
```

### Analytics Views (4 Views)

```sql
-- Community dashboard metrics
SELECT * FROM community_dashboard;
-- Returns: total_active_students, total_lecturers, total_events, etc.

-- Student engagement ranking
SELECT * FROM engagement_metrics;
-- Returns: students ranked by activity (posts, projects, events)

-- Project team & technology stats
SELECT * FROM project_statistics;
-- Returns: team size, technologies used per project

-- Profile completeness scoring
SELECT * FROM student_profile_completeness;
-- Returns: profile quality score for each student
```

### Key Relationships

```text
students
  ├── roles (1:1) → Student role: student, lecturer, admin, alumni
  ├── student_interests (1:M) → Multiple interests per student
  ├── events (1:M) → Events created by student
  ├── discussion_posts (1:M) → Discussion posts authored
  ├── projects (1:M) → Projects owned
  ├── project_members (1:M) → Projects collaborated on
  ├── resources (1:M) → Resources uploaded
  ├── mentors (1:1) → Mentoring expertise
  └── publications (1:M) → Research papers/dissertations

projects
  ├── project_members (1:M) → Collaborative team
  ├── project_technologies (1:M) → Tech stack
  └── students (M:M via project_members)

events
  ├── event_registrations (1:M) → Student registrations
  └── students (M:M via event_registrations)

resources
  └── resource_categories (M:1) → Category classification

interests
  └── student_interests (1:M) → Many students per interest

technologies
  └── project_technologies (1:M) → Multiple projects per tech
```

---

## 📚 Seed Data Summary

Realistic sample data for immediate testing:

```text
STUDENTS                8
  ├── MSc Students     5 (Bilal, Sarah, Daniel, Emily, James)
  ├── Lecturers        2 (Dr. Johnson, Dr. Wong)
  └── Admin            1

EVENTS                  5
  ├── Seminars         2 (AI Research Seminar)
  ├── Workshops        1 (MLOps Workshop)
  ├── Networking       1 (AI Careers Evening)
  └── Study Groups     1 (Deep Learning Study Group)
  └── Registrations   12 (Across all events)

RESOURCES              10
  ├── Tutorials        4 (ML, PyTorch, CV, Prompt Engineering)
  ├── Papers           1 (Transformer paper)
  ├── Books            1 (Statistical Learning)
  ├── Datasets         1 (ImageNet)
  ├── Guides           2 (Career, Ethical AI)
  └── Documentation    1 (LangChain)

PROJECTS                6
  ├── In Progress      4 (Essay Feedback, Career Bot, MLOps Tool, Game AI)
  ├── Completed        1 (Sentiment Analysis)
  ├── Planning         1 (Community Platform)
  ├── Members         15 (Team collaborations)
  └── Technologies    21 (Tech stacks tracked)

DISCUSSIONS             7
  ├── Posts            7 (Career, ML resources, MLOps, AI Safety)
  └── Comments        10 (Peer replies and advice)

MENTORING               4
  ├── Mentors          4 (With expertise areas)
  └── Requests         3 (Pending and accepted)

PUBLICATIONS            2
  ├── Papers           1 (Conference - Dr. Johnson)
  └── Surveys          1 (Journal - Dr. Wong)

ANNOUNCEMENTS           4
SURVEYS                 2
```

---

## 🔍 Sample Queries

### Community Dashboard

```sql
-- Get community metrics
SELECT * FROM community_dashboard;

-- Output:
-- total_active_students | 8
-- total_lecturers       | 2
-- total_events          | 5
-- total_resources       | 10
-- total_projects        | 6
-- total_posts           | 7
-- students_with_projects| 5
-- total_publications    | 2
```

### Upcoming Events

```sql
SELECT
    title,
    event_date,
    location,
    max_capacity,
    (SELECT COUNT(*) FROM event_registrations WHERE event_id = events.id) as registrations
FROM events
WHERE event_date > NOW()
ORDER BY event_date;

-- Output:
-- AI Research Seminar | 2025-10-05 | Online | 200 | 3
-- Deep Learning Study | 2025-10-03 | Online | 50  | 3
-- MLOps Workshop      | 2025-10-12 | Online | 100 | 2
```

### Most Popular Interests

```sql
SELECT
    i.name,
    COUNT(*) as member_count
FROM interests i
JOIN student_interests si ON i.id = si.interest_id
GROUP BY i.name
ORDER BY member_count DESC;

-- Output:
-- Machine Learning | 3
-- Deep Learning    | 2
-- Computer Vision  | 1
-- Generative AI    | 2
```

### Featured Projects

```sql
SELECT
    title,
    status,
    owner_id,
    github_url
FROM projects
WHERE is_featured = TRUE;

-- Output:
-- Automated Academic Essay Feedback System | in_progress | 1
-- AI Career Assistant Chatbot             | in_progress | 2
-- UWE MSc AI Community Platform          | planning    | 1
```

### Student Engagement Ranking

```sql
SELECT * FROM engagement_metrics LIMIT 5;

-- Output:
-- full_name      | discussion_posts | projects_joined | events_attended
-- Bilal Muhammed | 2                | 5              | 3
-- Sarah Ahmed    | 1                | 2              | 2
-- Daniel Smith   | 1                | 2              | 2
```

### Student Profile Completeness

```sql
SELECT
    full_name,
    completeness_score
FROM student_profile_completeness
ORDER BY completeness_score DESC;

-- Output:
-- Bilal Muhammed | 4
-- Sarah Ahmed    | 4
-- Dr. Wong       | 3
-- Emily Chen     | 3
```

---

## 🛠️ Development

### Technology Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Database | PostgreSQL | 18 |
| ORM | SQLAlchemy | 2.0+ |
| Backend | FastAPI | 0.100+ |
| Frontend | Next.js | 14+ |
| Styling | Tailwind CSS | 3.4+ |
| Auth | Auth.js | 5.0+ |

### Environment Variables

Create `.env.local`:

```bash
DATABASE_URL="postgresql://app:PASSWORD@host:5432/bilalai?sslmode=require"
NEXTAUTH_SECRET="your-secret-key"
NEXTAUTH_URL="http://localhost:3000"
OPENAI_API_KEY="your-api-key"
PGVECTOR_ENABLED=false  # Enable when pgvector extension is deployed
```

### Local Development

```bash
# Clone repository
git clone https://github.com/Bilalabdulkadir/Bilalabdulkadir.git
cd Bilalabdulkadir

# Install dependencies
npm install

# Run development server
npm run dev

# Open http://localhost:3000
```

---

## 📈 Analytics Dashboards

Pre-built views for analytics:

### 1. Community Dashboard

```sql
SELECT * FROM community_dashboard;
```

**Use Cases:**
- Platform metrics overview
- Growth tracking
- Engagement monitoring

### 2. Engagement Metrics

```sql
SELECT * FROM engagement_metrics;
```

**Use Cases:**
- Identify active students
- Reward contributions
- Retention analysis

### 3. Project Statistics

```sql
SELECT * FROM project_statistics;
```

**Use Cases:**
- Project discovery
- Technology trends
- Team collaboration insights

### 4. Profile Completeness

```sql
SELECT * FROM student_profile_completeness;
```

**Use Cases:**
- Encourage profile completion
- Identify inactive users
- Personalization triggers

---

## 🚀 Deployment

### pgEdge Cloud (Recommended)

```bash
# Already configured at:
# Host: fairly-large-locust-7aa7ddd.use2.pgedge.cloud
# Database: bilalai

# Run schema + seed data as shown in Quick Start above
```

### Docker (Local/Self-Hosted)

```dockerfile
FROM postgres:18
COPY schema/ /docker-entrypoint-initdb.d/
ENV POSTGRES_DB=bilalai
ENV POSTGRES_USER=app
EXPOSE 5432
```

```bash
docker run -e POSTGRES_PASSWORD=your_password -d bilalai-postgres
```

### GitHub Actions (CI/CD)

```yaml
name: Deploy Schema

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy schema
        env:
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: psql $DATABASE_URL -f schema/01_enhanced_community_schema.sql
```

---

## 📋 Verification Checklist

Before going live:

```text
✅ Schema deployed (26 tables created)
✅ All foreign keys valid
✅ Seed data loaded successfully
✅ Record counts verified (8 students, 5 events, etc.)
✅ Analytics views operational
✅ Full-text search configured
✅ Indexes created for performance
✅ No orphaned records
✅ Community dashboard returns data
✅ Engagement metrics calculated
✅ Ready for application development
```

Run verification:

```bash
psql -f schema/00_DEPLOYMENT_GUIDE.sql
```

---

## 🔮 Future Enhancements

### Phase 1: MVP ✅ (Current)
- Authentication system
- Student profiles & interests
- Event management
- Resource library
- Discussion forums
- Project showcase

### Phase 2: Community Features
- Mentoring program (ready)
- Publication tracking (ready)
- Notification system (ready)
- Survey/feedback tools (ready)
- Activity logging (ready)

### Phase 3: AI-Powered Features
- pgvector embeddings
- Semantic search (RAG)
- AI community assistant chatbot
- Research collaboration matching
- Career recommendation engine
- Dissertation topic suggestions

### Future Integrations
- Microsoft Teams
- Google Calendar
- Slack notifications
- LinkedIn integration
- GitHub syncing

---

## 📖 Documentation

### For Database Administrators

- **Schema Overview:** See `schema/01_enhanced_community_schema.sql`
- **Deployment Guide:** See `schema/00_DEPLOYMENT_GUIDE.sql`
- **Verification Queries:** Run queries in deployment guide

### For Backend Developers

- **Database Connection:** Use `DATABASE_URL` environment variable
- **SQLAlchemy Models:** Generate from schema using `sqlacodegen`
- **API Endpoints:** Define CRUD operations per entity

### For Frontend Developers

- **API Integration:** Connect to FastAPI backend
- **State Management:** Use React Query or SWR
- **Authentication:** Auth.js integration with email/OAuth
- **Analytics:** Query views for dashboard data

---

## 🤝 Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is part of the UWE Bristol MSc Artificial Intelligence program.

---

## 🆘 Support & Troubleshooting

### Common Issues

**Error: "violates foreign key constraint"**
- Run deployment verification (Step 0-2) to identify missing references

**Error: "duplicate key violates unique constraint"**
- Data already exists; either delete or reset database and reload schema

**Error: "column does not exist"**
- Schema may have changed; compare with `01_enhanced_community_schema.sql`

**Slow queries**
- Verify indexes are created; run queries from `00_DEPLOYMENT_GUIDE.sql`

### More Help

- 📧 Email: [bilal2.muhammed@live.uwe.ac.uk](mailto:bilal2.muhammed@live.uwe.ac.uk)
- 💻 GitHub Issues: [Report bugs here](https://github.com/Bilalabdulkadir/Bilalabdulkadir/issues)
- 📚 Documentation: See `schema/` directory

---

## 🎓 About

**Built for:** UWE Bristol MSc Artificial Intelligence  
**Developer:** Bilal Muhammed  
**Started:** September 2026  
**Status:** Database & Schema Complete | Application Development in Progress

---

**Last Updated:** September 28, 2026
