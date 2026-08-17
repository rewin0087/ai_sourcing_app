# frozen_string_literal: true

# Seed diverse candidate profiles for development/testing.
# Embeddings are intentionally omitted — run the next step separately:
#   rails embeddings:generate_all

SEED_CANDIDATES = [
  # ── 1. Maria Santos — Senior Full Stack Engineer ───────────────────────────
  {
    email: "maria.santos@example.com",
    full_name: "Maria Santos",
    first_name: "Maria",
    last_name: "Santos",
    phone: "+1-415-555-0101",
    city: "San Francisco",
    state: "CA",
    country: "US",
    postal_code: "94105",
    current_title: "Senior Full Stack Engineer",
    about_me: "Passionate full-stack engineer with 8+ years of experience building scalable web applications. Specializes in Ruby on Rails backends and React frontends. Strong advocate for clean code and test-driven development.",
    linkedin_url: "https://linkedin.com/in/mariasantos",
    github_url: "https://github.com/mariasantos",
    skills: [
      { name: "Ruby",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Ruby on Rails",  category: "Backend",        proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96, skill_type: "Primary",   year_last_used: 2026 },
      { name: "React",          category: "Frontend",       proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PostgreSQL",     category: "Databases",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redis",          category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",            category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "TypeScript",     category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "RSpec",          category: "Testing",        proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "TechFlow Inc",
        job_title: "Senior Full Stack Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 3,
        start_date: "2022-03-01",
        end_date: nil,
        description: "Lead engineer for the core SaaS platform serving 50,000+ users. Architected microservices migration from monolith, reducing p99 latency by 40%. Mentored a team of 4 junior engineers.",
        projects: [
          {
            project_name: "Microservices Migration",
            project_status: 1,
            start_date: "2022-06-01",
            end_date: "2023-03-31",
            description: "Extracted 6 bounded contexts from the Rails monolith into independent services with event-driven communication via Kafka.",
            skills_used: "Ruby on Rails, Kafka, PostgreSQL, Docker"
          },
          {
            project_name: "Real-time Analytics Dashboard",
            project_status: 1,
            start_date: "2023-04-01",
            end_date: "2023-09-30",
            description: "Built a live analytics dashboard using ActionCable and React, reducing customer support tickets by 25%.",
            skills_used: "React, ActionCable, Redis, Chart.js"
          }
        ]
      },
      {
        company_name: "Startup Labs",
        job_title: "Full Stack Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Remote",
        location_type: 2,
        start_date: "2019-06-01",
        end_date: "2022-02-28",
        description: "Built the MVP and scaled the product to Series A. Owned backend API development, React frontend, and CI/CD pipeline.",
        projects: [
          {
            project_name: "Marketplace MVP",
            project_status: 1,
            start_date: "2019-06-01",
            end_date: "2020-12-31",
            description: "Designed and built full-stack marketplace from scratch, enabling $2M in GMV within the first year.",
            skills_used: "Ruby on Rails, React, PostgreSQL, Stripe, AWS"
          }
        ]
      },
      {
        company_name: "Digital Agency Co",
        job_title: "Junior Rails Developer",
        work_status: 0,
        employment_type: 1,
        location: "New York, NY",
        location_type: 1,
        start_date: "2017-08-01",
        end_date: "2019-05-31",
        description: "Developed and maintained client web applications using Ruby on Rails. Collaborated with designers to implement pixel-perfect UIs.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "University of California, Berkeley",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2013-08-01",
        end_date: "2017-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Solutions Architect - Associate",
        issuing_org: "Amazon Web Services",
        issue_date: "2023-06-01",
        expiry_date: "2026-06-01",
        skills_covered: "AWS, Cloud Architecture, EC2, S3, RDS, Lambda"
      }
    ]
  },

  # ── 2. James Reyes — Senior Data Scientist ────────────────────────────────
  {
    email: "james.reyes@example.com",
    full_name: "James Reyes",
    first_name: "James",
    last_name: "Reyes",
    phone: "+1-312-555-0202",
    city: "Chicago",
    state: "IL",
    country: "US",
    postal_code: "60601",
    current_title: "Senior Data Scientist",
    about_me: "Data scientist with 6+ years of experience turning raw data into business insights. Expert in machine learning, statistical modeling, and data visualization. Passionate about applying ML to real-world problems in healthcare and finance.",
    linkedin_url: "https://linkedin.com/in/jamesreyes",
    github_url: "https://github.com/jreyes",
    skills: [
      { name: "Python",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "scikit-learn",  category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TensorFlow",    category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "SQL",           category: "Databases",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Pandas",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "NumPy",         category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Tableau",       category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2025 },
      { name: "Apache Spark",  category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",           category: "Source Control", proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "HealthTech Analytics",
        job_title: "Senior Data Scientist",
        work_status: 1,
        employment_type: 1,
        location: "Chicago, IL",
        location_type: 3,
        start_date: "2021-09-01",
        end_date: nil,
        description: "Leading data science initiatives for predictive patient outcomes and hospital resource optimization. Developed ML models that reduced readmission rates by 18%.",
        projects: [
          {
            project_name: "Patient Readmission Predictor",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-08-31",
            description: "Gradient boosting model on EHR data to predict 30-day readmission risk, achieving 0.81 AUC and deployed across 12 hospitals.",
            skills_used: "Python, scikit-learn, XGBoost, PostgreSQL, AWS SageMaker"
          },
          {
            project_name: "ICU Bed Occupancy Forecasting",
            project_status: 1,
            start_date: "2023-03-01",
            end_date: "2023-10-31",
            description: "Time-series forecasting model for ICU bed demand, reducing over-staffing costs by $2M annually.",
            skills_used: "Python, Prophet, Apache Spark, Tableau"
          }
        ]
      },
      {
        company_name: "FinEdge Capital",
        job_title: "Data Scientist",
        work_status: 0,
        employment_type: 1,
        location: "Chicago, IL",
        location_type: 1,
        start_date: "2018-07-01",
        end_date: "2021-08-31",
        description: "Developed credit risk scoring models and fraud detection systems for a fintech platform processing $500M+ in annual loans.",
        projects: [
          {
            project_name: "Credit Risk Model v2",
            project_status: 1,
            start_date: "2019-01-01",
            end_date: "2019-12-31",
            description: "Rebuilt credit scoring model using ensemble methods, improving Gini coefficient from 0.52 to 0.71.",
            skills_used: "Python, LightGBM, Pandas, SQL, Tableau"
          },
          {
            project_name: "Real-time Fraud Detection",
            project_status: 1,
            start_date: "2020-06-01",
            end_date: "2021-03-31",
            description: "Streaming fraud detection pipeline using isolation forest and neural networks, reducing fraud losses by 32%.",
            skills_used: "Python, TensorFlow, Kafka, PostgreSQL"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Illinois Urbana-Champaign",
        degree_obtained: "Master of Science",
        field_of_study: "Statistics",
        start_date: "2016-08-01",
        end_date: "2018-05-31",
        still_studying: false,
        description: "Thesis: Bayesian methods for high-dimensional data analysis in genomics"
      },
      {
        school_name: "De La Salle University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Mathematics",
        start_date: "2012-06-01",
        end_date: "2016-03-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Google Professional Data Engineer",
        issuing_org: "Google Cloud",
        issue_date: "2022-11-01",
        expiry_date: "2024-11-01",
        skills_covered: "BigQuery, Dataflow, Pub/Sub, ML on GCP"
      }
    ]
  },

  # ── 3. Ana Cruz — Senior DevOps Engineer ──────────────────────────────────
  {
    email: "ana.cruz@example.com",
    full_name: "Ana Cruz",
    first_name: "Ana",
    last_name: "Cruz",
    phone: "+1-206-555-0303",
    city: "Seattle",
    state: "WA",
    country: "US",
    postal_code: "98101",
    current_title: "Senior DevOps Engineer",
    about_me: "Cloud and DevOps engineer with 6 years of experience designing resilient, scalable infrastructure. Deep expertise in AWS, Kubernetes, and infrastructure-as-code. Passionate about developer experience and platform reliability.",
    linkedin_url: "https://linkedin.com/in/anacruz-devops",
    github_url: "https://github.com/anacruz",
    skills: [
      { name: "AWS",            category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",     category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Docker",         category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "GitHub Actions", category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Helm",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",         category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bash",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Prometheus",     category: "Other",          proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "CloudScale Systems",
        job_title: "Senior DevOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 2,
        start_date: "2023-01-01",
        end_date: nil,
        description: "Designing and operating multi-region Kubernetes infrastructure for a B2B SaaS platform with 99.99% SLA. Leading platform engineering team of 5 engineers.",
        projects: [
          {
            project_name: "Multi-region EKS Migration",
            project_status: 1,
            start_date: "2023-02-01",
            end_date: "2023-11-30",
            description: "Migrated all workloads from EC2 to EKS across 3 AWS regions with zero-downtime deployments using blue/green strategy.",
            skills_used: "Kubernetes, AWS EKS, Terraform, Helm, GitHub Actions"
          },
          {
            project_name: "Observability Platform",
            project_status: 1,
            start_date: "2024-01-01",
            end_date: "2024-06-30",
            description: "Implemented centralized Loki + Prometheus/Thanos + Tempo stack, reducing MTTR from 45 minutes to 8 minutes.",
            skills_used: "Prometheus, Grafana, Loki, Tempo, Kubernetes"
          }
        ]
      },
      {
        company_name: "E-Commerce Giant",
        job_title: "DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 1,
        start_date: "2020-05-01",
        end_date: "2022-12-31",
        description: "Maintained CI/CD pipelines and AWS infrastructure for a high-traffic e-commerce platform handling 10M daily transactions.",
        projects: [
          {
            project_name: "CI/CD Modernization",
            project_status: 1,
            start_date: "2020-09-01",
            end_date: "2021-06-30",
            description: "Migrated from Jenkins to GitHub Actions, reducing build times by 60% and cutting infrastructure costs by $180K/year.",
            skills_used: "GitHub Actions, Docker, AWS, Terraform"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Washington",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Engineering",
        start_date: "2016-09-01",
        end_date: "2020-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified DevOps Engineer - Professional",
        issuing_org: "Amazon Web Services",
        issue_date: "2022-08-01",
        expiry_date: "2025-08-01",
        skills_covered: "AWS DevOps, CI/CD, CloudFormation, CodePipeline"
      },
      {
        certificate_name: "Certified Kubernetes Administrator (CKA)",
        issuing_org: "Cloud Native Computing Foundation",
        issue_date: "2023-03-01",
        expiry_date: "2026-03-01",
        skills_covered: "Kubernetes, Container Orchestration, Networking, Storage"
      }
    ]
  },

  # ── 4. Kevin Tan — Mobile Software Engineer ───────────────────────────────
  {
    email: "kevin.tan@example.com",
    full_name: "Kevin Tan",
    first_name: "Kevin",
    last_name: "Tan",
    phone: "+1-512-555-0404",
    city: "Austin",
    state: "TX",
    country: "US",
    postal_code: "78701",
    current_title: "Mobile Software Engineer",
    about_me: "Mobile developer with 4 years of experience building cross-platform and native iOS applications. Focused on creating smooth, performant user experiences. Experience shipping apps with 1M+ downloads.",
    linkedin_url: "https://linkedin.com/in/kevintan-mobile",
    github_url: "https://github.com/kevtan",
    skills: [
      { name: "React Native", category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TypeScript",   category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Firebase",     category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redux",        category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Expo",         category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Swift",        category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2025 },
      { name: "GraphQL",      category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Jest",         category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",          category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "GigWork Mobile",
        job_title: "Mobile Software Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Austin, TX",
        location_type: 3,
        start_date: "2023-04-01",
        end_date: nil,
        description: "Building the consumer-facing React Native app for an on-demand services marketplace with 1.2M active users. Improved app launch time by 35% and drove App Store rating from 3.8 to 4.6.",
        projects: [
          {
            project_name: "Push Notification Overhaul",
            project_status: 1,
            start_date: "2023-07-01",
            end_date: "2023-12-31",
            description: "Redesigned push notification infrastructure using Firebase Cloud Messaging with smart throttling, increasing opt-in rates by 22%.",
            skills_used: "React Native, Firebase, TypeScript, Redux"
          },
          {
            project_name: "Offline Mode",
            project_status: 1,
            start_date: "2024-02-01",
            end_date: "2024-07-31",
            description: "Implemented full offline mode with optimistic UI updates and background sync, enabling use in low-connectivity areas.",
            skills_used: "React Native, Redux, AsyncStorage, TypeScript"
          }
        ]
      },
      {
        company_name: "AppWorks Studio",
        job_title: "Junior Mobile Developer",
        work_status: 0,
        employment_type: 1,
        location: "Austin, TX",
        location_type: 1,
        start_date: "2021-08-01",
        end_date: "2023-03-31",
        description: "Developed and shipped 5 client mobile applications across iOS and Android using React Native and Expo.",
        projects: [
          {
            project_name: "Fitness Tracker App",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-06-30",
            description: "Health and fitness tracking app with HealthKit integration and real-time workout analytics. Reached #12 in App Store Health category.",
            skills_used: "React Native, Expo, Firebase, TypeScript"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Texas A&M University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Software Engineering",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 5. Sofia Mendoza — Senior Product Designer ────────────────────────────
  {
    email: "sofia.mendoza@example.com",
    full_name: "Sofia Mendoza",
    first_name: "Sofia",
    last_name: "Mendoza",
    phone: "+1-305-555-0505",
    city: "Miami",
    state: "FL",
    country: "US",
    postal_code: "33101",
    current_title: "Senior Product Designer",
    about_me: "Product designer with 7 years of experience crafting intuitive digital experiences for B2B and B2C products. Expert in design systems, user research, and rapid prototyping. Driven by data-informed design decisions.",
    linkedin_url: "https://linkedin.com/in/sofiamendoza-design",
    github_url: nil,
    skills: [
      { name: "Figma",              category: "Other",    proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "UX Research",        category: "Other",    proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Prototyping",        category: "Other",    proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Design Systems",     category: "Frontend", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "HTML",               category: "Frontend", proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "CSS",                category: "Frontend", proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Adobe Illustrator",  category: "Other",    proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2025 },
      { name: "Usability Testing",  category: "Testing",  proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Notion",             category: "Other",    proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "FinServ Platform",
        job_title: "Senior Product Designer",
        work_status: 1,
        employment_type: 1,
        location: "Miami, FL",
        location_type: 2,
        start_date: "2022-09-01",
        end_date: nil,
        description: "Lead designer for the consumer mobile banking and investment app used by 800K+ customers. Owns end-to-end design process from user research through developer handoff.",
        projects: [
          {
            project_name: "Banking App Redesign",
            project_status: 1,
            start_date: "2022-10-01",
            end_date: "2023-07-31",
            description: "Complete redesign of mobile banking experience, improving task completion rate from 68% to 89% and NPS by 22 points.",
            skills_used: "Figma, UX Research, Prototyping, Usability Testing"
          },
          {
            project_name: "Component Design System",
            project_status: 1,
            start_date: "2023-08-01",
            end_date: "2024-02-29",
            description: "Built comprehensive design system with 120+ components, reducing design-to-dev handoff time by 40%.",
            skills_used: "Figma, Design Systems, Documentation"
          }
        ]
      },
      {
        company_name: "E-Learning Corp",
        job_title: "Product Designer",
        work_status: 0,
        employment_type: 1,
        location: "Miami, FL",
        location_type: 3,
        start_date: "2019-01-01",
        end_date: "2022-08-31",
        description: "Owned product design for an online learning platform with 2M+ learners. Drove 35% increase in course completion rates through UX improvements.",
        projects: [
          {
            project_name: "Course Player Redesign",
            project_status: 1,
            start_date: "2020-03-01",
            end_date: "2020-11-30",
            description: "Redesigned the video course player with interactive transcripts and progress tracking, increasing session duration by 28%.",
            skills_used: "Figma, Prototyping, UX Research, HTML, CSS"
          }
        ]
      },
      {
        company_name: "Creative Digital Agency",
        job_title: "UI/UX Designer",
        work_status: 0,
        employment_type: 1,
        location: "Miami, FL",
        location_type: 1,
        start_date: "2017-03-01",
        end_date: "2018-12-31",
        description: "Designed websites and mobile apps for clients across retail, healthcare, and hospitality sectors.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "Savannah College of Art and Design",
        degree_obtained: "Bachelor of Fine Arts",
        field_of_study: "Interaction Design",
        start_date: "2013-09-01",
        end_date: "2017-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Google UX Design Certificate",
        issuing_org: "Google",
        issue_date: "2021-04-01",
        expiry_date: nil,
        skills_covered: "UX Research, Wireframing, Prototyping, Usability Testing"
      }
    ]
  },

  # ── 6. Luis Garcia — Backend Software Engineer ────────────────────────────
  {
    email: "luis.garcia@example.com",
    full_name: "Luis Garcia",
    first_name: "Luis",
    last_name: "Garcia",
    phone: "+1-972-555-0606",
    city: "Dallas",
    state: "TX",
    country: "US",
    postal_code: "75201",
    current_title: "Backend Software Engineer",
    about_me: "Backend engineer with 3 years of experience building high-throughput Java and Node.js services. Focused on writing clean, testable code and maintainable architectures. Currently deepening knowledge in distributed systems patterns.",
    linkedin_url: "https://linkedin.com/in/luisgarcia-dev",
    github_url: "https://github.com/lgarcia-dev",
    skills: [
      { name: "Java",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Spring Boot", category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "REST APIs",   category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "MySQL",       category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Node.js",     category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",      category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redis",       category: "Databases",      proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 12, skill_type: "Secondary", year_last_used: 2026 },
      { name: "JUnit",       category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",         category: "Source Control", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "RetailTech Solutions",
        job_title: "Backend Software Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Dallas, TX",
        location_type: 3,
        start_date: "2023-08-01",
        end_date: nil,
        description: "Building backend microservices for a retail inventory management platform used by 500+ stores. Developing Spring Boot APIs and optimizing high-load database queries.",
        projects: [
          {
            project_name: "Inventory Sync Service",
            project_status: 1,
            start_date: "2023-10-01",
            end_date: "2024-04-30",
            description: "Real-time inventory synchronization service handling 50K events/minute with at-least-once delivery guarantees via Kafka.",
            skills_used: "Java, Spring Boot, MySQL, Kafka, Docker"
          }
        ]
      },
      {
        company_name: "Logistics Corp",
        job_title: "Junior Backend Developer",
        work_status: 0,
        employment_type: 1,
        location: "Dallas, TX",
        location_type: 1,
        start_date: "2021-07-01",
        end_date: "2023-07-31",
        description: "Developed and maintained Java-based APIs for a logistics tracking platform. Collaborated with frontend teams on RESTful API design.",
        projects: [
          {
            project_name: "Shipment Tracking API",
            project_status: 1,
            start_date: "2022-02-01",
            end_date: "2022-09-30",
            description: "Redesigned the shipment tracking REST API, reducing average response time from 800ms to 120ms through query optimization and Redis caching.",
            skills_used: "Java, Spring Boot, MySQL, Redis, JUnit"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Texas at Dallas",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Oracle Certified Professional: Java SE 17 Developer",
        issuing_org: "Oracle",
        issue_date: "2022-09-01",
        expiry_date: nil,
        skills_covered: "Java SE, OOP, Streams, Concurrency, Collections"
      }
    ]
  },

  # ── 7. Rachel Kim — Senior QA Engineer / SDET ─────────────────────────────
  {
    email: "rachel.kim@example.com",
    full_name: "Rachel Kim",
    first_name: "Rachel",
    last_name: "Kim",
    phone: "+1-503-555-0707",
    city: "Portland",
    state: "OR",
    country: "US",
    postal_code: "97201",
    current_title: "Senior QA Engineer / SDET",
    about_me: "Quality engineer with 5 years of experience building robust test automation frameworks from scratch. Passionate about shifting quality left and embedding a testing culture across engineering teams. Expert in API, UI, and performance testing.",
    linkedin_url: "https://linkedin.com/in/rachelkim-qa",
    github_url: "https://github.com/rachelkim-qa",
    skills: [
      { name: "Cypress",   category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Selenium",  category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2025 },
      { name: "Python",    category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Postman",   category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "k6",        category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Jest",      category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "SQL",       category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "JIRA",      category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",       category: "Source Control", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "InsureTech Co",
        job_title: "Senior QA Engineer / SDET",
        work_status: 1,
        employment_type: 1,
        location: "Portland, OR",
        location_type: 2,
        start_date: "2022-04-01",
        end_date: nil,
        description: "Leading QA strategy for a digital insurance platform. Built and owns the end-to-end test automation suite covering UI, API, and performance testing. Reduced release cycle from 4 weeks to 1 week through CI/CD integration.",
        projects: [
          {
            project_name: "E2E Automation Framework",
            project_status: 1,
            start_date: "2022-05-01",
            end_date: "2022-12-31",
            description: "Built a Cypress-based E2E automation framework from scratch with 400+ test cases, achieving 92% coverage on critical user flows.",
            skills_used: "Cypress, JavaScript, GitHub Actions, Docker"
          },
          {
            project_name: "API Contract Testing",
            project_status: 1,
            start_date: "2023-06-01",
            end_date: "2024-01-31",
            description: "Introduced consumer-driven contract testing with Pact across 8 microservices, catching 15+ breaking changes before production.",
            skills_used: "Pact, Postman, Python, GitHub Actions"
          }
        ]
      },
      {
        company_name: "SaaS Platform Inc",
        job_title: "QA Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Portland, OR",
        location_type: 1,
        start_date: "2019-10-01",
        end_date: "2022-03-31",
        description: "Manual and automation testing for a B2B project management SaaS. Built Selenium regression suite and championed API testing adoption.",
        projects: [
          {
            project_name: "Selenium Regression Suite",
            project_status: 1,
            start_date: "2020-04-01",
            end_date: "2021-01-31",
            description: "Migrated 200+ manual test cases to Selenium automation, cutting regression execution time from 5 days to 4 hours.",
            skills_used: "Selenium, Python, JIRA, SQL"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Portland State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Information Systems",
        start_date: "2015-09-01",
        end_date: "2019-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "ISTQB Certified Tester - Foundation Level",
        issuing_org: "ISTQB",
        issue_date: "2021-03-01",
        expiry_date: nil,
        skills_covered: "Software Testing Fundamentals, Test Design, Test Management"
      }
    ]
  },

  # ── 8. Michael Chen — AI/ML Engineer ─────────────────────────────────────
  {
    email: "michael.chen@example.com",
    full_name: "Michael Chen",
    first_name: "Michael",
    last_name: "Chen",
    phone: "+1-617-555-0808",
    city: "Boston",
    state: "MA",
    country: "US",
    postal_code: "02101",
    current_title: "Senior AI/ML Engineer",
    about_me: "AI/ML engineer with 6 years of experience developing production ML systems and LLM-powered applications. Deep expertise in NLP, RAG architectures, and vector databases. Published researcher with 3 papers in applied NLP.",
    linkedin_url: "https://linkedin.com/in/michaelchen-ai",
    github_url: "https://github.com/mchen-ai",
    skills: [
      { name: "Python",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PyTorch",       category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "LangChain",     category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Primary",   year_last_used: 2026 },
      { name: "OpenAI API",    category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Hugging Face",  category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "pgvector",      category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "PostgreSQL",    category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "FastAPI",       category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "TensorFlow",    category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2025 },
      { name: "AWS",           category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Cognix AI",
        job_title: "Senior AI/ML Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 2,
        start_date: "2023-06-01",
        end_date: nil,
        description: "Building LLM-powered enterprise document intelligence platform. Designing RAG pipelines, fine-tuning open-source models, and deploying ML inference at scale.",
        projects: [
          {
            project_name: "Enterprise RAG Pipeline",
            project_status: 1,
            start_date: "2023-07-01",
            end_date: "2024-01-31",
            description: "Multi-stage RAG pipeline with hybrid search (vector + BM25) and cross-encoder re-ranking, improving answer accuracy from 61% to 84% on domain Q&A benchmarks.",
            skills_used: "LangChain, OpenAI API, pgvector, PostgreSQL, Hugging Face, Python"
          },
          {
            project_name: "Domain LLM Fine-tuning",
            project_status: 1,
            start_date: "2024-03-01",
            end_date: "2024-09-30",
            description: "Fine-tuned Mistral-7B on proprietary legal and financial documents using QLoRA, achieving GPT-3.5-comparable accuracy at 10x lower inference cost.",
            skills_used: "PyTorch, Hugging Face PEFT, QLoRA, AWS SageMaker"
          }
        ]
      },
      {
        company_name: "MIT NLP Research Lab",
        job_title: "Research Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Cambridge, MA",
        location_type: 1,
        start_date: "2021-01-01",
        end_date: "2023-05-31",
        description: "Research engineer collaborating with faculty on applied NLP projects. Co-authored 3 conference papers on low-resource NLP and evaluation methodology.",
        projects: [
          {
            project_name: "Cross-lingual Transfer Learning Study",
            project_status: 1,
            start_date: "2021-04-01",
            end_date: "2022-03-31",
            description: "Zero-shot cross-lingual transfer experiments for low-resource Southeast Asian languages using mBERT and XLM-R. Published at EMNLP 2022.",
            skills_used: "Python, PyTorch, Hugging Face Transformers, Google Cloud"
          }
        ]
      },
      {
        company_name: "DataDriven Inc",
        job_title: "ML Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 3,
        start_date: "2019-06-01",
        end_date: "2020-12-31",
        description: "Built recommendation systems and NLP features for an e-commerce search and discovery platform.",
        projects: [
          {
            project_name: "Semantic Product Search",
            project_status: 1,
            start_date: "2019-09-01",
            end_date: "2020-06-30",
            description: "Replaced keyword-based product search with a bi-encoder semantic retrieval model, improving search relevance by 31% as measured by NDCG@10.",
            skills_used: "Python, TensorFlow, Elasticsearch, FastAPI"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Massachusetts Institute of Technology",
        degree_obtained: "Master of Science",
        field_of_study: "Electrical Engineering and Computer Science",
        start_date: "2017-09-01",
        end_date: "2019-05-31",
        still_studying: false,
        description: "Thesis: Efficient transformers for long-document understanding"
      },
      {
        school_name: "University of Michigan",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2013-09-01",
        end_date: "2017-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Machine Learning - Specialty",
        issuing_org: "Amazon Web Services",
        issue_date: "2023-02-01",
        expiry_date: "2026-02-01",
        skills_covered: "AWS SageMaker, ML on AWS, Feature Engineering, Model Deployment"
      },
      {
        certificate_name: "DeepLearning.AI TensorFlow Developer",
        issuing_org: "DeepLearning.AI",
        issue_date: "2020-08-01",
        expiry_date: nil,
        skills_covered: "TensorFlow, Neural Networks, CNNs, NLP, Sequence Models"
      }
    ]
  },

  # ── 9. Clara Nguyen — Frontend Engineer ──────────────────────────────────
  {
    email: "clara.nguyen@example.com",
    full_name: "Clara Nguyen",
    first_name: "Clara",
    last_name: "Nguyen",
    phone: "+1-714-555-0901",
    city: "Los Angeles",
    state: "CA",
    country: "US",
    postal_code: "90001",
    current_title: "Frontend Engineer",
    about_me: "Frontend engineer with 5 years of experience building performant, accessible web applications. Specializes in Vue.js and Angular with a strong eye for design-implementation fidelity. Advocates for web accessibility and Core Web Vitals optimization.",
    linkedin_url: "https://linkedin.com/in/claranguyen-fe",
    github_url: "https://github.com/claranguyen",
    skills: [
      { name: "Vue.js",       category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TypeScript",   category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Angular",      category: "Frontend",       proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2024 },
      { name: "Pinia",        category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Tailwind CSS", category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Vite",         category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Vitest",       category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "GraphQL",      category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",          category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Media Stream Co",
        job_title: "Frontend Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Los Angeles, CA",
        location_type: 2,
        start_date: "2022-07-01",
        end_date: nil,
        description: "Building the Vue.js web app for a video streaming platform serving 3M+ monthly active users. Owns Core Web Vitals optimization and accessibility compliance (WCAG 2.1 AA).",
        projects: [
          {
            project_name: "Video Player Rewrite",
            project_status: 1,
            start_date: "2022-09-01",
            end_date: "2023-04-30",
            description: "Rewrote legacy Flash-era video player in Vue 3 with HLS.js, reducing LCP by 42% and eliminating all WCAG A/AA violations.",
            skills_used: "Vue.js, TypeScript, HLS.js, Tailwind CSS"
          },
          {
            project_name: "Design System Migration",
            project_status: 1,
            start_date: "2024-01-01",
            end_date: "2024-08-31",
            description: "Migrated 80+ UI components from a bespoke CSS framework to a new Tailwind-based design system, cutting design-debt by 60%.",
            skills_used: "Vue.js, Tailwind CSS, Storybook, TypeScript"
          }
        ]
      },
      {
        company_name: "AdTech Agency",
        job_title: "Junior Frontend Developer",
        work_status: 0,
        employment_type: 1,
        location: "Los Angeles, CA",
        location_type: 1,
        start_date: "2020-06-01",
        end_date: "2022-06-30",
        description: "Developed Angular-based campaign dashboards and landing page builders for Fortune 500 advertising clients.",
        projects: [
          {
            project_name: "Campaign Dashboard v2",
            project_status: 1,
            start_date: "2021-02-01",
            end_date: "2021-10-31",
            description: "Rebuilt the real-time campaign analytics dashboard in Angular, adding granular filtering and CSV export used by 200+ media buyers daily.",
            skills_used: "Angular, TypeScript, RxJS, Chart.js"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "California State University, Fullerton",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Information Systems",
        start_date: "2016-08-01",
        end_date: "2020-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 10. Benjamin Okafor — Application Security Engineer ───────────────────
  {
    email: "benjamin.okafor@example.com",
    full_name: "Benjamin Okafor",
    first_name: "Benjamin",
    last_name: "Okafor",
    phone: "+1-347-555-1001",
    city: "New York",
    state: "NY",
    country: "US",
    postal_code: "10001",
    current_title: "Application Security Engineer",
    about_me: "Security engineer with 7 years of experience across penetration testing, AppSec program building, and secure SDLC integration. Specialist in web application vulnerabilities and threat modeling. Speaker at OWASP NYC chapter.",
    linkedin_url: "https://linkedin.com/in/benjaminokafor-sec",
    github_url: "https://github.com/bokafor-sec",
    skills: [
      { name: "Penetration Testing", category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "OWASP Top 10",        category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Python",              category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Burp Suite",          category: "Testing",        proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Threat Modeling",     category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",                 category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",              category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bash",                category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",                 category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "SecureLayer Inc",
        job_title: "Senior Application Security Engineer",
        work_status: 1,
        employment_type: 1,
        location: "New York, NY",
        location_type: 3,
        start_date: "2021-05-01",
        end_date: nil,
        description: "Leading AppSec program for a fintech company processing $4B+ annually. Running SAST/DAST pipelines, conducting design reviews, and managing the bug bounty program. Reduced critical vulnerability MTTR from 18 days to 4 days.",
        projects: [
          {
            project_name: "Secure SDLC Implementation",
            project_status: 1,
            start_date: "2021-07-01",
            end_date: "2022-06-30",
            description: "Embedded automated security gates (SAST, SCA, secret scanning) into GitHub Actions pipelines across 40 repositories, catching 200+ vulnerabilities before merge.",
            skills_used: "GitHub Actions, Semgrep, Snyk, Python, Bash"
          },
          {
            project_name: "OAuth 2.0 Threat Model",
            project_status: 1,
            start_date: "2023-02-01",
            end_date: "2023-05-31",
            description: "Performed end-to-end threat model of the customer-facing OAuth 2.0 / OIDC flows, identifying and remediating 3 high-severity token leakage vectors.",
            skills_used: "Threat Modeling, Burp Suite, OWASP Top 10"
          }
        ]
      },
      {
        company_name: "RedTeam Consulting",
        job_title: "Security Engineer",
        work_status: 0,
        employment_type: 1,
        location: "New York, NY",
        location_type: 1,
        start_date: "2018-03-01",
        end_date: "2021-04-30",
        description: "Conducted web application, API, and mobile penetration tests for financial services, healthcare, and SaaS clients. Delivered 60+ assessment reports.",
        projects: [
          {
            project_name: "Healthcare Portal Pentest",
            project_status: 1,
            start_date: "2019-09-01",
            end_date: "2019-11-30",
            description: "Full-scope web application pentest uncovering IDOR vulnerability exposing 1.2M patient records, enabling pre-breach remediation for the client.",
            skills_used: "Burp Suite, Python, OWASP Top 10, Metasploit"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "New York University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Cybersecurity",
        start_date: "2014-09-01",
        end_date: "2018-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Offensive Security Certified Professional (OSCP)",
        issuing_org: "Offensive Security",
        issue_date: "2020-04-01",
        expiry_date: nil,
        skills_covered: "Penetration Testing, Exploit Development, Active Directory, Buffer Overflows"
      },
      {
        certificate_name: "Certified Ethical Hacker (CEH)",
        issuing_org: "EC-Council",
        issue_date: "2019-01-01",
        expiry_date: nil,
        skills_covered: "Ethical Hacking, Network Security, Web Application Security"
      }
    ]
  },

  # ── 11. Priya Patel — Data Engineer ───────────────────────────────────────
  {
    email: "priya.patel@example.com",
    full_name: "Priya Patel",
    first_name: "Priya",
    last_name: "Patel",
    phone: "+1-408-555-1101",
    city: "San Jose",
    state: "CA",
    country: "US",
    postal_code: "95101",
    current_title: "Data Engineer",
    about_me: "Data engineer with 4 years of experience designing and maintaining large-scale data pipelines and analytics infrastructure. Specializes in the modern data stack: dbt, Airflow, and Snowflake. Passionate about data quality and observable pipelines.",
    linkedin_url: "https://linkedin.com/in/priyapatel-data",
    github_url: "https://github.com/priyapatel-de",
    skills: [
      { name: "Python",      category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "dbt",         category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Apache Airflow", category: "Backend",     proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Snowflake",   category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "SQL",         category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Spark",       category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",         category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Kafka",       category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",         category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Commerce Analytics Co",
        job_title: "Data Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Jose, CA",
        location_type: 2,
        start_date: "2022-11-01",
        end_date: nil,
        description: "Building and maintaining the data platform that powers analytics for a $1B e-commerce business. Manages 200+ dbt models and Airflow DAGs processing 15TB of daily event data.",
        projects: [
          {
            project_name: "Real-time Events Pipeline",
            project_status: 1,
            start_date: "2023-03-01",
            end_date: "2023-10-31",
            description: "Built a Kafka-to-Snowflake streaming pipeline ingesting 50M clickstream events/day with sub-5-minute latency, replacing nightly batch jobs.",
            skills_used: "Kafka, Python, Snowflake, Airflow, AWS"
          },
          {
            project_name: "Data Quality Framework",
            project_status: 1,
            start_date: "2024-02-01",
            end_date: "2024-07-31",
            description: "Implemented dbt tests + Great Expectations data contracts across all critical models, reducing silent data errors by 85%.",
            skills_used: "dbt, Great Expectations, Python, Slack API"
          }
        ]
      },
      {
        company_name: "HR Software Inc",
        job_title: "Junior Data Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Jose, CA",
        location_type: 1,
        start_date: "2020-08-01",
        end_date: "2022-10-31",
        description: "Built ETL pipelines for HR analytics product, migrated legacy stored-procedure workflows to dbt, and supported Snowflake data warehouse adoption.",
        projects: [
          {
            project_name: "Legacy ETL to dbt Migration",
            project_status: 1,
            start_date: "2021-04-01",
            end_date: "2022-01-31",
            description: "Converted 120 stored-procedure-based transformations to dbt models with full test coverage, cutting pipeline failures from 15/week to <1/week.",
            skills_used: "dbt, Snowflake, SQL, Python, Airflow"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of California, San Diego",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Data Science",
        start_date: "2016-09-01",
        end_date: "2020-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "dbt Certified Developer",
        issuing_org: "dbt Labs",
        issue_date: "2023-07-01",
        expiry_date: nil,
        skills_covered: "dbt Core, dbt Cloud, SQL Transformations, Data Testing, Documentation"
      }
    ]
  },

  # ── 12. David Sato — Engineering Manager ──────────────────────────────────
  {
    email: "david.sato@example.com",
    full_name: "David Sato",
    first_name: "David",
    last_name: "Sato",
    phone: "+1-425-555-1201",
    city: "Bellevue",
    state: "WA",
    country: "US",
    postal_code: "98004",
    current_title: "Engineering Manager",
    about_me: "Engineering manager with 10+ years in software development, the last 4 managing high-performing backend and platform teams. Background in distributed systems and Go. Focused on technical excellence, clear prioritization, and growing engineers into senior roles.",
    linkedin_url: "https://linkedin.com/in/davidsato-em",
    github_url: "https://github.com/dsato",
    skills: [
      { name: "Go",               category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2024 },
      { name: "Python",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 120, skill_type: "Secondary", year_last_used: 2025 },
      { name: "PostgreSQL",       category: "Databases",      proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 120, skill_type: "Secondary", year_last_used: 2025 },
      { name: "Kubernetes",       category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years",  years_of_exp_in_months: 36,  skill_type: "Secondary", year_last_used: 2025 },
      { name: "AWS",              category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "System Design",    category: "Other",          proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 120, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Agile / Scrum",    category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Git",              category: "Source Control", proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 120, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Nimbus Cloud",
        job_title: "Engineering Manager",
        work_status: 1,
        employment_type: 1,
        location: "Bellevue, WA",
        location_type: 3,
        start_date: "2021-02-01",
        end_date: nil,
        description: "Managing two backend teams (12 engineers) responsible for the core billing and developer API platform. Drove team to 99.95% API availability and 3x throughput improvement over 2 years.",
        projects: [
          {
            project_name: "Billing Platform Rewrite",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2023-06-30",
            description: "Led the 18-month initiative to replace a fragile Ruby billing monolith with a Go-based microservices platform, enabling metered pricing and reducing billing errors by 94%.",
            skills_used: "Go, PostgreSQL, Kafka, Kubernetes, AWS"
          }
        ]
      },
      {
        company_name: "Nimbus Cloud",
        job_title: "Senior Backend Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Bellevue, WA",
        location_type: 1,
        start_date: "2018-09-01",
        end_date: "2021-01-31",
        description: "Senior engineer on the developer API platform team, designing high-throughput Go services and mentoring junior engineers.",
        projects: [
          {
            project_name: "API Rate Limiting Service",
            project_status: 1,
            start_date: "2019-06-01",
            end_date: "2020-01-31",
            description: "Designed and implemented a distributed token-bucket rate limiter in Go handling 500K rps with sub-millisecond overhead.",
            skills_used: "Go, Redis, PostgreSQL, gRPC"
          }
        ]
      },
      {
        company_name: "ScaleStack Inc",
        job_title: "Backend Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 1,
        start_date: "2015-07-01",
        end_date: "2018-08-31",
        description: "Backend engineer building Python/Django APIs and data processing pipelines for a B2B analytics platform.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "University of Washington",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2011-09-01",
        end_date: "2015-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 13. Isabella Torres — Android Developer ───────────────────────────────
  {
    email: "isabella.torres@example.com",
    full_name: "Isabella Torres",
    first_name: "Isabella",
    last_name: "Torres",
    phone: "+1-305-555-1301",
    city: "Miami",
    state: "FL",
    country: "US",
    postal_code: "33130",
    current_title: "Android Software Engineer",
    about_me: "Android engineer with 5 years of experience shipping production apps to 1M+ users. Deep expertise in Kotlin, Jetpack Compose, and clean architecture. Passionate about smooth animations and battery-efficient background processing.",
    linkedin_url: "https://linkedin.com/in/isabellatorres-android",
    github_url: "https://github.com/isatorres",
    skills: [
      { name: "Kotlin",            category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Jetpack Compose",   category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Android SDK",       category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Retrofit",          category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Room",              category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Coroutines",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Firebase",          category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "JUnit",             category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",               category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "InsuranceNow",
        job_title: "Android Software Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Miami, FL",
        location_type: 2,
        start_date: "2022-01-01",
        end_date: nil,
        description: "Building the Android app for a digital insurance platform with 850K installs. Led migration from XML views to Jetpack Compose and introduced MVI architecture.",
        projects: [
          {
            project_name: "Jetpack Compose Migration",
            project_status: 1,
            start_date: "2022-04-01",
            end_date: "2023-02-28",
            description: "Migrated the 60-screen app from XML/MVP to Jetpack Compose + MVI architecture, improving render frame rate from 42fps to 60fps on mid-range devices.",
            skills_used: "Kotlin, Jetpack Compose, MVI, Android SDK"
          },
          {
            project_name: "Offline Claims Filing",
            project_status: 1,
            start_date: "2023-10-01",
            end_date: "2024-04-30",
            description: "Implemented offline-capable claims filing using Room + WorkManager with conflict-free sync, enabling use in areas with poor connectivity.",
            skills_used: "Kotlin, Room, WorkManager, Coroutines, Retrofit"
          }
        ]
      },
      {
        company_name: "Fintech Mobile Co",
        job_title: "Junior Android Developer",
        work_status: 0,
        employment_type: 1,
        location: "Miami, FL",
        location_type: 1,
        start_date: "2020-03-01",
        end_date: "2021-12-31",
        description: "Developed features for a digital wallet Android app with 500K+ users. Focused on payment flow UX and biometric authentication.",
        projects: [
          {
            project_name: "Biometric Auth Integration",
            project_status: 1,
            start_date: "2020-08-01",
            end_date: "2021-01-31",
            description: "Integrated Android BiometricPrompt API for fingerprint and face unlock, increasing session re-authentication speed by 70%.",
            skills_used: "Kotlin, Android SDK, BiometricPrompt, Keystore"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Florida International University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2016-08-01",
        end_date: "2020-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Associate Android Developer",
        issuing_org: "Google",
        issue_date: "2021-06-01",
        expiry_date: nil,
        skills_covered: "Android SDK, Kotlin, Jetpack, Room, WorkManager"
      }
    ]
  },

  # ── 14. Ethan Blackwell — Site Reliability Engineer ───────────────────────
  {
    email: "ethan.blackwell@example.com",
    full_name: "Ethan Blackwell",
    first_name: "Ethan",
    last_name: "Blackwell",
    phone: "+1-415-555-1401",
    city: "San Francisco",
    state: "CA",
    country: "US",
    postal_code: "94107",
    current_title: "Site Reliability Engineer",
    about_me: "SRE with 6 years of experience ensuring reliability for large-scale distributed systems. Background in software engineering with a focus on observability, incident response, and capacity planning. Believes in eliminating toil and building self-healing systems.",
    linkedin_url: "https://linkedin.com/in/ethanblackwell-sre",
    github_url: "https://github.com/eblackwell-sre",
    skills: [
      { name: "Go",              category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Prometheus",      category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Python",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Terraform",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "GCP",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "gRPC",            category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bash",            category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "StreamPlatform",
        job_title: "Senior Site Reliability Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 2,
        start_date: "2022-06-01",
        end_date: nil,
        description: "On-call for a live video streaming platform serving 8M concurrent peak viewers. Owns SLO framework, capacity planning, and chaos engineering program. Reduced P1 incident rate by 65% YoY.",
        projects: [
          {
            project_name: "SLO & Error Budget Framework",
            project_status: 1,
            start_date: "2022-09-01",
            end_date: "2023-03-31",
            description: "Defined and automated SLO tracking for 25 critical services using Prometheus + Grafana, giving engineering teams real-time error budget visibility.",
            skills_used: "Prometheus, Grafana, Go, Kubernetes, Python"
          },
          {
            project_name: "Chaos Engineering Program",
            project_status: 1,
            start_date: "2023-07-01",
            end_date: "2024-01-31",
            description: "Launched quarterly game days using Litmus Chaos on GKE, discovering and fixing 11 reliability gaps before they caused user-facing incidents.",
            skills_used: "Litmus Chaos, Kubernetes, GCP, Go, Python"
          }
        ]
      },
      {
        company_name: "CloudOps Ltd",
        job_title: "Site Reliability Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 3,
        start_date: "2019-01-01",
        end_date: "2022-05-31",
        description: "SRE for a multi-tenant SaaS platform. Reduced infrastructure costs by 35% through right-sizing and GCP committed use discounts while maintaining 99.9% availability.",
        projects: [
          {
            project_name: "Auto-scaling Optimization",
            project_status: 1,
            start_date: "2020-03-01",
            end_date: "2020-11-30",
            description: "Tuned GKE HPA/VPA policies based on load testing data, reducing over-provisioning by 40% and saving $420K/year in compute costs.",
            skills_used: "Kubernetes, GCP, Prometheus, Python, Terraform"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Stanford University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2014-09-01",
        end_date: "2018-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Google Professional Cloud DevOps Engineer",
        issuing_org: "Google Cloud",
        issue_date: "2022-10-01",
        expiry_date: "2024-10-01",
        skills_covered: "GKE, Cloud Monitoring, SRE Practices, CI/CD on GCP"
      }
    ]
  },

  # ── 15. Aisha Mohammed — Cloud Solutions Architect ────────────────────────
  {
    email: "aisha.mohammed@example.com",
    full_name: "Aisha Mohammed",
    first_name: "Aisha",
    last_name: "Mohammed",
    phone: "+1-469-555-1501",
    city: "Dallas",
    state: "TX",
    country: "US",
    postal_code: "75202",
    current_title: "Cloud Solutions Architect",
    about_me: "Cloud Solutions Architect with 8 years of experience designing enterprise cloud architectures on Azure and AWS. Led cloud migrations for Fortune 500 companies totaling $30M+ in infrastructure. Specializes in hybrid cloud, disaster recovery, and Well-Architected Framework reviews.",
    linkedin_url: "https://linkedin.com/in/aishamohammed-cloud",
    github_url: nil,
    skills: [
      { name: "Azure",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",          category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36,  skill_type: "Secondary", year_last_used: 2025 },
      { name: "Bicep",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Networking",      category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Security & IAM",  category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Apex Consulting Group",
        job_title: "Principal Cloud Solutions Architect",
        work_status: 1,
        employment_type: 1,
        location: "Dallas, TX",
        location_type: 3,
        start_date: "2020-09-01",
        end_date: nil,
        description: "Leading cloud architecture engagements for enterprise clients across banking, healthcare, and manufacturing. Responsible for pre-sales, technical design, and delivery oversight.",
        projects: [
          {
            project_name: "Bank Core System Cloud Migration",
            project_status: 1,
            start_date: "2021-04-01",
            end_date: "2022-09-30",
            description: "Architected migration of a regional bank's on-premise core banking system to Azure, achieving PCI-DSS compliance and 40% infrastructure cost reduction.",
            skills_used: "Azure, Terraform, Bicep, Azure Networking, Azure Security Center"
          },
          {
            project_name: "Multi-cloud DR Strategy",
            project_status: 1,
            start_date: "2023-01-01",
            end_date: "2023-08-31",
            description: "Designed and validated an active-passive disaster recovery architecture spanning Azure primary and AWS secondary regions, achieving RPO < 5 min and RTO < 20 min.",
            skills_used: "Azure, AWS, Terraform, Route 53, Traffic Manager"
          }
        ]
      },
      {
        company_name: "TeleCom Global",
        job_title: "Senior Cloud Architect",
        work_status: 0,
        employment_type: 1,
        location: "Dallas, TX",
        location_type: 1,
        start_date: "2017-03-01",
        end_date: "2020-08-31",
        description: "Designed AWS and Azure infrastructure for a telecom company serving 20M subscribers. Led the migration of 200+ workloads from on-premise data centers to cloud.",
        projects: [
          {
            project_name: "Data Center Exit Program",
            project_status: 1,
            start_date: "2018-01-01",
            end_date: "2019-12-31",
            description: "Executed migration of 200 workloads to AWS/Azure over 24 months, retiring 3 physical data centers and saving $8M annually in colocation costs.",
            skills_used: "AWS, Azure, Terraform, Kubernetes, Networking"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Texas at Austin",
        degree_obtained: "Master of Science",
        field_of_study: "Information Technology",
        start_date: "2014-08-01",
        end_date: "2016-05-31",
        still_studying: false,
        description: nil
      },
      {
        school_name: "University of Lagos",
        degree_obtained: "Bachelor of Engineering",
        field_of_study: "Computer Engineering",
        start_date: "2009-09-01",
        end_date: "2013-07-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Microsoft Certified: Azure Solutions Architect Expert",
        issuing_org: "Microsoft",
        issue_date: "2021-08-01",
        expiry_date: "2023-08-01",
        skills_covered: "Azure Architecture, Compute, Networking, Storage, Security, Cost Optimization"
      },
      {
        certificate_name: "AWS Certified Solutions Architect - Professional",
        issuing_org: "Amazon Web Services",
        issue_date: "2022-03-01",
        expiry_date: "2025-03-01",
        skills_covered: "AWS Architecture, Multi-account Strategy, Disaster Recovery, Cost Optimization"
      }
    ]
  },

  # ── 16. Carlos Villanueva — PHP / Laravel Backend Developer ───────────────
  {
    email: "carlos.villanueva@example.com",
    full_name: "Carlos Villanueva",
    first_name: "Carlos",
    last_name: "Villanueva",
    phone: "+1-602-555-1601",
    city: "Phoenix",
    state: "AZ",
    country: "US",
    postal_code: "85001",
    current_title: "Backend Developer",
    about_me: "Backend developer with 4 years of experience building web applications with PHP/Laravel and REST APIs. Comfortable across the full web stack and experienced with deploying to AWS. Looking to deepen expertise in distributed systems.",
    linkedin_url: "https://linkedin.com/in/carlosvillanueva-dev",
    github_url: "https://github.com/cvillanueva",
    skills: [
      { name: "PHP",         category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Laravel",     category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "MySQL",       category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Vue.js",      category: "Frontend",       proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redis",       category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",         category: "Cloud & DevOps", proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",      category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "PHPUnit",     category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",         category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "PropertyHub",
        job_title: "Backend Developer",
        work_status: 1,
        employment_type: 1,
        location: "Phoenix, AZ",
        location_type: 3,
        start_date: "2023-02-01",
        end_date: nil,
        description: "Building Laravel REST APIs and backend services for a real estate listings platform with 200K monthly visitors. Owns API performance and queue-based background job infrastructure.",
        projects: [
          {
            project_name: "Property Search API Optimization",
            project_status: 1,
            start_date: "2023-05-01",
            end_date: "2023-10-31",
            description: "Refactored N+1-heavy Eloquent queries and added Redis caching, reducing property search API median response from 1.4s to 180ms.",
            skills_used: "Laravel, MySQL, Redis, PHP"
          },
          {
            project_name: "Document Generation Service",
            project_status: 1,
            start_date: "2024-03-01",
            end_date: "2024-07-31",
            description: "Built asynchronous PDF lease document generation using Laravel Queues + S3, removing a 10-second blocking call from the user-facing flow.",
            skills_used: "Laravel, AWS S3, Redis, Docker"
          }
        ]
      },
      {
        company_name: "Digital Agency Sonora",
        job_title: "Junior Web Developer",
        work_status: 0,
        employment_type: 1,
        location: "Phoenix, AZ",
        location_type: 1,
        start_date: "2021-05-01",
        end_date: "2023-01-31",
        description: "Developed and maintained custom Laravel applications and WordPress sites for local business clients. Built RESTful APIs consumed by Vue.js frontends.",
        projects: [
          {
            project_name: "Inventory Management Portal",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-07-31",
            description: "Built full-stack inventory management app (Laravel + Vue.js) for a regional distributor, replacing manual spreadsheet workflows for 50 staff.",
            skills_used: "Laravel, Vue.js, MySQL, PHPUnit"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Arizona State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Information Systems",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 17. Nathan Brooks — .NET / C# Backend Developer ──────────────────────
  {
    email: "nathan.brooks@example.com",
    full_name: "Nathan Brooks",
    first_name: "Nathan",
    last_name: "Brooks",
    phone: "+1-614-555-1701",
    city: "Columbus",
    state: "OH",
    country: "US",
    postal_code: "43215",
    current_title: "Senior .NET Developer",
    about_me: "Backend developer with 5 years of experience building enterprise .NET applications for financial services and healthcare. Deep expertise in C#, ASP.NET Core, and Azure. Committed to clean architecture and SOLID principles.",
    linkedin_url: "https://linkedin.com/in/nathanbrooks-dotnet",
    github_url: "https://github.com/nbrooks-dev",
    skills: [
      { name: "C#",              category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "ASP.NET Core",    category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Entity Framework",category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "SQL Server",      category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Azure",           category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",          category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "xUnit",           category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "RabbitMQ",        category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "MedRecord Systems",
        job_title: "Senior .NET Developer",
        work_status: 1,
        employment_type: 1,
        location: "Columbus, OH",
        location_type: 3,
        start_date: "2022-04-01",
        end_date: nil,
        description: "Building HIPAA-compliant electronic health record APIs using ASP.NET Core and Azure. Leads a squad of 3 developers, owns architectural decisions for the core patient data domain.",
        projects: [
          {
            project_name: "FHIR API Implementation",
            project_status: 1,
            start_date: "2022-07-01",
            end_date: "2023-05-31",
            description: "Implemented HL7 FHIR R4 REST API enabling interoperability with 15 partner hospital systems, unlocking a $2M enterprise contract.",
            skills_used: "C#, ASP.NET Core, Azure API Management, SQL Server, xUnit"
          },
          {
            project_name: "Async Notification Pipeline",
            project_status: 1,
            start_date: "2024-01-01",
            end_date: "2024-06-30",
            description: "Replaced synchronous email/SMS dispatch with a RabbitMQ-backed async pipeline, improving API response times by 300ms p99 and enabling retry semantics.",
            skills_used: "C#, RabbitMQ, Docker, Azure Service Bus"
          }
        ]
      },
      {
        company_name: "FinanceOne Corp",
        job_title: ".NET Developer",
        work_status: 0,
        employment_type: 1,
        location: "Columbus, OH",
        location_type: 1,
        start_date: "2019-08-01",
        end_date: "2022-03-31",
        description: "Developed ASP.NET Core APIs and WinForms tooling for a regional bank's internal operations platform. Migrated legacy VB.NET codebases to modern C#.",
        projects: [
          {
            project_name: "Loan Processing API",
            project_status: 1,
            start_date: "2020-06-01",
            end_date: "2021-02-28",
            description: "Built a new loan origination REST API replacing a 15-year-old SOAP service, reducing loan processing time from 4 hours to 12 minutes.",
            skills_used: "C#, ASP.NET Core, Entity Framework, SQL Server"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Ohio State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science and Engineering",
        start_date: "2015-08-01",
        end_date: "2019-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Microsoft Certified: Azure Developer Associate",
        issuing_org: "Microsoft",
        issue_date: "2023-05-01",
        expiry_date: "2025-05-01",
        skills_covered: "Azure App Service, Azure Functions, Azure Storage, Cosmos DB, API Management"
      }
    ]
  },

  # ── 18. Mei Lin — Staff Software Engineer ─────────────────────────────────
  {
    email: "mei.lin@example.com",
    full_name: "Mei Lin",
    first_name: "Mei",
    last_name: "Lin",
    phone: "+1-650-555-1801",
    city: "Palo Alto",
    state: "CA",
    country: "US",
    postal_code: "94301",
    current_title: "Staff Software Engineer",
    about_me: "Staff engineer with 11+ years building and operating large-scale distributed systems. Specializes in consensus protocols, storage engines, and cross-team technical alignment. Frequent contributor to open-source infrastructure projects. Experienced tech lead for 8–15 engineer teams.",
    linkedin_url: "https://linkedin.com/in/meilin-staff",
    github_url: "https://github.com/meilin-infra",
    skills: [
      { name: "Java",            category: "Languages",      proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 132, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Go",              category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Distributed Systems", category: "Backend",   proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 132, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kafka",           category: "Backend",        proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Cassandra",       category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "PostgreSQL",      category: "Databases",      proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 120, skill_type: "Secondary", year_last_used: 2025 },
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 132, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Horizon Payments",
        job_title: "Staff Software Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Palo Alto, CA",
        location_type: 2,
        start_date: "2020-07-01",
        end_date: nil,
        description: "Technical lead for the core payments infrastructure team (12 engineers). Setting technical direction for a platform processing $40B in annual transaction volume. Driving company-wide migration from monolith to event-driven architecture.",
        projects: [
          {
            project_name: "Event-driven Architecture Migration",
            project_status: 1,
            start_date: "2021-01-01",
            end_date: "2023-06-30",
            description: "Designed and led 2.5-year migration from synchronous monolith to Kafka-backed event-driven microservices across 6 teams, enabling 10x throughput growth.",
            skills_used: "Java, Kafka, AWS, Kubernetes, Cassandra"
          },
          {
            project_name: "Idempotency Framework",
            project_status: 1,
            start_date: "2023-09-01",
            end_date: "2024-03-31",
            description: "Designed a company-wide idempotency library for payment APIs, eliminating duplicate-charge incidents and reducing customer refund rate by 99.3%.",
            skills_used: "Java, PostgreSQL, Redis, Kafka"
          }
        ]
      },
      {
        company_name: "DataBricks (Early Stage)",
        job_title: "Senior Software Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 1,
        start_date: "2016-02-01",
        end_date: "2020-06-30",
        description: "Core contributor on the storage and execution engine team. Designed compaction and indexing features adopted by thousands of enterprise customers.",
        projects: [
          {
            project_name: "Delta Lake Compaction Engine",
            project_status: 1,
            start_date: "2018-03-01",
            end_date: "2019-06-30",
            description: "Designed and shipped the auto-compaction engine for Delta Lake, reducing small-file overhead by 80% for streaming workloads.",
            skills_used: "Java, Spark, Go, AWS S3"
          }
        ]
      },
      {
        company_name: "Oracle",
        job_title: "Software Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Redwood City, CA",
        location_type: 1,
        start_date: "2013-06-01",
        end_date: "2016-01-31",
        description: "Java developer on the Oracle Database kernel team, working on query optimizer improvements and JDBC driver performance.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "Carnegie Mellon University",
        degree_obtained: "Master of Science",
        field_of_study: "Computer Science",
        start_date: "2011-08-01",
        end_date: "2013-05-31",
        still_studying: false,
        description: "Specialization: Distributed Systems and Programming Languages"
      },
      {
        school_name: "Tsinghua University",
        degree_obtained: "Bachelor of Engineering",
        field_of_study: "Software Engineering",
        start_date: "2007-09-01",
        end_date: "2011-07-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 19. Omar Hassan — Blockchain / Web3 Developer ─────────────────────────
  {
    email: "omar.hassan@example.com",
    full_name: "Omar Hassan",
    first_name: "Omar",
    last_name: "Hassan",
    phone: "+1-786-555-1901",
    city: "Miami",
    state: "FL",
    country: "US",
    postal_code: "33132",
    current_title: "Blockchain Engineer",
    about_me: "Blockchain engineer with 3 years of experience building and auditing smart contracts on Ethereum and Solana. Specializes in DeFi protocols, NFT infrastructure, and cross-chain bridges. Strong Solidity security background with 2 public audit reports.",
    linkedin_url: "https://linkedin.com/in/omarhassan-web3",
    github_url: "https://github.com/ohassan-web3",
    skills: [
      { name: "Solidity",       category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Rust",           category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TypeScript",     category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Hardhat",        category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Ethers.js",      category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "React",          category: "Frontend",       proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Node.js",        category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "The Graph",      category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "DeFi Protocol Labs",
        job_title: "Blockchain Engineer",
        work_status: 1,
        employment_type: 3,
        location: "Remote",
        location_type: 2,
        start_date: "2023-01-01",
        end_date: nil,
        description: "Core smart contract developer for a DeFi lending protocol with $120M TVL. Writes and audits Solidity contracts, builds Hardhat test suites, and maintains The Graph subgraphs for on-chain indexing.",
        projects: [
          {
            project_name: "Variable Rate Interest Model",
            project_status: 1,
            start_date: "2023-04-01",
            end_date: "2023-09-30",
            description: "Designed and deployed a dynamic interest rate model contract with on-chain utilization curve parameters, improving capital efficiency by 22%.",
            skills_used: "Solidity, Hardhat, TypeScript, Ethers.js"
          },
          {
            project_name: "Cross-chain Bridge Integration",
            project_status: 1,
            start_date: "2024-02-01",
            end_date: "2024-08-31",
            description: "Integrated LayerZero OFT bridge to enable USDC deposits from Arbitrum and Base, growing protocol TVL by $30M in 60 days.",
            skills_used: "Solidity, LayerZero, Hardhat, TypeScript"
          }
        ]
      },
      {
        company_name: "NFT Studio",
        job_title: "Junior Blockchain Developer",
        work_status: 0,
        employment_type: 1,
        location: "Miami, FL",
        location_type: 2,
        start_date: "2021-09-01",
        end_date: "2022-12-31",
        description: "Built ERC-721 and ERC-1155 NFT contracts and minting dApps for art and gaming clients. Deployed 12 collections generating $4M in primary sales.",
        projects: [
          {
            project_name: "Generative PFP Collection",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-05-31",
            description: "End-to-end development of a 10K generative PFP project including ERC-721A contract, merkle-proof allowlist, and React minting dApp. Sold out in 4 minutes.",
            skills_used: "Solidity, ERC-721A, React, Ethers.js, Hardhat"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Miami",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Certified Blockchain Developer - Ethereum",
        issuing_org: "Blockchain Council",
        issue_date: "2022-07-01",
        expiry_date: nil,
        skills_covered: "Ethereum, Solidity, Smart Contracts, DApps, Web3.js"
      }
    ]
  },

  # ── 20. Diana Ferreira — Data Analyst ─────────────────────────────────────
  {
    email: "diana.ferreira@example.com",
    full_name: "Diana Ferreira",
    first_name: "Diana",
    last_name: "Ferreira",
    phone: "+1-617-555-2001",
    city: "Boston",
    state: "MA",
    country: "US",
    postal_code: "02110",
    current_title: "Senior Data Analyst",
    about_me: "Data analyst with 4 years of experience translating business questions into actionable insights. Expert in SQL, Python, and Power BI. Comfortable working with stakeholders at all levels to define metrics and build self-serve dashboards. Currently learning dbt to grow toward a data engineering path.",
    linkedin_url: "https://linkedin.com/in/dianaferreira-data",
    github_url: "https://github.com/dferreira-analytics",
    skills: [
      { name: "SQL",           category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Python",        category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Power BI",      category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Excel",         category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Tableau",       category: "Other",          proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2025 },
      { name: "BigQuery",      category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "dbt",           category: "Backend",        proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 10, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Pandas",        category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",           category: "Source Control", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "EdTech Insights",
        job_title: "Senior Data Analyst",
        work_status: 1,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 3,
        start_date: "2023-01-01",
        end_date: nil,
        description: "Primary analyst for a 3M-student edtech platform. Partners with Product, Marketing, and Finance to build dashboards, run A/B experiment analyses, and define north-star metrics.",
        projects: [
          {
            project_name: "Student Retention Dashboard",
            project_status: 1,
            start_date: "2023-03-01",
            end_date: "2023-07-31",
            description: "Built a Power BI cohort retention dashboard revealing a 28% churn spike at week 3; insights drove a product intervention that reduced churn by 14%.",
            skills_used: "Power BI, SQL, BigQuery, Python"
          },
          {
            project_name: "A/B Test Analysis Framework",
            project_status: 1,
            start_date: "2024-01-01",
            end_date: "2024-05-31",
            description: "Standardized the company's experiment analysis process in Python, reducing time-to-insight per experiment from 3 days to 4 hours.",
            skills_used: "Python, Pandas, SQL, BigQuery, Statsmodels"
          }
        ]
      },
      {
        company_name: "Retail Chain Group",
        job_title: "Data Analyst",
        work_status: 0,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 1,
        start_date: "2020-09-01",
        end_date: "2022-12-31",
        description: "Analyst for merchandising and supply chain teams at a 300-store retail chain. Built weekly KPI reports and inventory forecasting models in Excel and SQL.",
        projects: [
          {
            project_name: "Inventory Forecast Model",
            project_status: 1,
            start_date: "2021-06-01",
            end_date: "2021-12-31",
            description: "Built a seasonal inventory demand forecast using Python and historical POS data, reducing overstock by $1.2M in the holiday quarter.",
            skills_used: "Python, Pandas, SQL, Excel"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Boston University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Business Analytics",
        start_date: "2016-09-01",
        end_date: "2020-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Microsoft Certified: Power BI Data Analyst Associate",
        issuing_org: "Microsoft",
        issue_date: "2022-10-01",
        expiry_date: "2024-10-01",
        skills_covered: "Power BI, DAX, Power Query, Data Modeling, Report Design"
      }
    ]
  },

  # ── 21. Jake Morrison — Full Stack JavaScript Developer ────────────────────
  {
    email: "jake.morrison@example.com",
    full_name: "Jake Morrison",
    first_name: "Jake",
    last_name: "Morrison",
    phone: "+1-512-555-2101",
    city: "Austin",
    state: "TX",
    country: "US",
    postal_code: "78702",
    current_title: "Full Stack JavaScript Developer",
    about_me: "Full stack JS developer with 3 years of experience shipping production Next.js apps and Node.js APIs. Comfortable with the entire lifecycle from design handoff to deployment. Enjoys working at early-stage startups where ownership and speed matter.",
    linkedin_url: "https://linkedin.com/in/jakemorrison-js",
    github_url: "https://github.com/jakemorrison",
    skills: [
      { name: "Next.js",       category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TypeScript",    category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Node.js",       category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "React",         category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PostgreSQL",    category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Prisma",        category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Tailwind CSS",  category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Vitest",        category: "Testing",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",           category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Launchpad AI",
        job_title: "Full Stack Developer",
        work_status: 1,
        employment_type: 1,
        location: "Austin, TX",
        location_type: 2,
        start_date: "2024-01-01",
        end_date: nil,
        description: "First engineering hire at an AI tooling startup. Owns the entire Next.js application — from UI to API routes — used by 4,000 paying customers.",
        projects: [
          {
            project_name: "AI Prompt Workspace",
            project_status: 1,
            start_date: "2024-02-01",
            end_date: "2024-07-31",
            description: "Built a collaborative prompt engineering workspace with real-time co-editing (Liveblocks), version history, and one-click deployment to Claude/OpenAI APIs.",
            skills_used: "Next.js, TypeScript, Tailwind CSS, Liveblocks, Prisma, PostgreSQL"
          }
        ]
      },
      {
        company_name: "Agency Stack",
        job_title: "Junior Web Developer",
        work_status: 0,
        employment_type: 1,
        location: "Austin, TX",
        location_type: 1,
        start_date: "2021-08-01",
        end_date: "2023-12-31",
        description: "Developed marketing sites and internal tools for agency clients using Next.js and Node.js. Delivered 20+ projects across SaaS, e-commerce, and media verticals.",
        projects: [
          {
            project_name: "E-commerce Platform",
            project_status: 1,
            start_date: "2022-05-01",
            end_date: "2022-11-30",
            description: "Built a headless e-commerce storefront with Next.js and Shopify Storefront API, achieving 98 Lighthouse performance score and 35% conversion rate improvement.",
            skills_used: "Next.js, TypeScript, Tailwind CSS, Shopify API, Node.js"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Texas at Austin",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Management Information Systems",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 22. Fatima Al-Rashid — Salesforce Developer ───────────────────────────
  {
    email: "fatima.alrashid@example.com",
    full_name: "Fatima Al-Rashid",
    first_name: "Fatima",
    last_name: "Al-Rashid",
    phone: "+1-832-555-2201",
    city: "Houston",
    state: "TX",
    country: "US",
    postal_code: "77002",
    current_title: "Senior Salesforce Developer",
    about_me: "Certified Salesforce developer with 5 years of experience implementing and customizing Sales Cloud, Service Cloud, and Experience Cloud. Adept at Apex, LWC, and complex integration patterns. Trusted by stakeholders to translate business processes into robust, maintainable Salesforce solutions.",
    linkedin_url: "https://linkedin.com/in/fatimaalrashid-sfdc",
    github_url: nil,
    skills: [
      { name: "Apex",             category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Lightning Web Components", category: "Frontend", proficiency: "Advanced", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Salesforce Flow",  category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "SOQL",             category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "REST APIs",        category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "JavaScript",       category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "MuleSoft",         category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2025 },
      { name: "Git",              category: "Source Control", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "EnergyFlow Solutions",
        job_title: "Senior Salesforce Developer",
        work_status: 1,
        employment_type: 1,
        location: "Houston, TX",
        location_type: 3,
        start_date: "2022-03-01",
        end_date: nil,
        description: "Lead Salesforce developer for an energy services company managing 1,200 enterprise accounts. Owns the Sales Cloud and Service Cloud org, supporting 400+ internal users. Reduced manual data entry by 70% through automation.",
        projects: [
          {
            project_name: "CPQ Implementation",
            project_status: 1,
            start_date: "2022-06-01",
            end_date: "2023-03-31",
            description: "Implemented Salesforce CPQ for complex energy service contracts with multi-tier pricing, reducing quote turnaround from 3 days to 4 hours.",
            skills_used: "Salesforce CPQ, Apex, SOQL, Salesforce Flow"
          },
          {
            project_name: "ERP Integration via MuleSoft",
            project_status: 1,
            start_date: "2023-07-01",
            end_date: "2024-01-31",
            description: "Designed bi-directional MuleSoft integration between Salesforce and SAP ERP, syncing contract and invoice data for 100% of enterprise accounts.",
            skills_used: "MuleSoft, REST APIs, Apex, SAP"
          }
        ]
      },
      {
        company_name: "CRM Consulting Partners",
        job_title: "Salesforce Developer",
        work_status: 0,
        employment_type: 1,
        location: "Houston, TX",
        location_type: 1,
        start_date: "2019-07-01",
        end_date: "2022-02-28",
        description: "Consulted on Salesforce implementations for 8 clients across healthcare, real estate, and manufacturing. Delivered Sales Cloud, Service Cloud, and Experience Cloud projects.",
        projects: [
          {
            project_name: "Patient Portal on Experience Cloud",
            project_status: 1,
            start_date: "2020-09-01",
            end_date: "2021-04-30",
            description: "Built a self-service patient portal on Salesforce Experience Cloud for a regional healthcare network, enabling online appointment scheduling and record access for 50K patients.",
            skills_used: "Lightning Web Components, Apex, SOQL, Salesforce Flow"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Houston",
        degree_obtained: "Bachelor of Business Administration",
        field_of_study: "Management Information Systems",
        start_date: "2015-08-01",
        end_date: "2019-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Salesforce Certified Platform Developer II",
        issuing_org: "Salesforce",
        issue_date: "2021-11-01",
        expiry_date: nil,
        skills_covered: "Apex, LWC, SOQL, Salesforce API, Asynchronous Processing"
      },
      {
        certificate_name: "Salesforce Certified CPQ Specialist",
        issuing_org: "Salesforce",
        issue_date: "2023-02-01",
        expiry_date: nil,
        skills_covered: "Salesforce CPQ, Pricing, Quoting, Contracts, Orders"
      }
    ]
  },

  # ── 23. Ryan O'Connor — Elixir / Phoenix Backend Developer ────────────────
  {
    email: "ryan.oconnor@example.com",
    full_name: "Ryan O'Connor",
    first_name: "Ryan",
    last_name: "O'Connor",
    phone: "+1-617-555-2301",
    city: "Boston",
    state: "MA",
    country: "US",
    postal_code: "02115",
    current_title: "Backend Engineer (Elixir)",
    about_me: "Backend engineer with 5 years of experience specializing in Elixir and the BEAM ecosystem. Passionate about fault-tolerant, concurrent system design. Built real-time features handling 500K+ concurrent WebSocket connections using Phoenix Channels. Regular speaker at local Elixir meetups.",
    linkedin_url: "https://linkedin.com/in/ryanoconnor-elixir",
    github_url: "https://github.com/roconnor-ex",
    skills: [
      { name: "Elixir",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Phoenix Framework",category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "OTP",              category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PostgreSQL",       category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redis",            category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "GraphQL",          category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",           category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",              category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",              category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "LiveCollaborate",
        job_title: "Senior Backend Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 2,
        start_date: "2022-10-01",
        end_date: nil,
        description: "Building real-time collaboration infrastructure for a whiteboarding SaaS with 500K+ concurrent WebSocket connections via Phoenix Channels. Owns the presence and locking systems that ensure conflict-free concurrent edits.",
        projects: [
          {
            project_name: "Distributed Presence System",
            project_status: 1,
            start_date: "2023-01-01",
            end_date: "2023-09-30",
            description: "Designed a Phoenix.Presence-based distributed presence system across 20-node cluster, enabling accurate who-is-online tracking with <50ms propagation latency.",
            skills_used: "Elixir, Phoenix, OTP, PostgreSQL, Redis"
          },
          {
            project_name: "Optimistic Locking Layer",
            project_status: 1,
            start_date: "2024-03-01",
            end_date: "2024-08-31",
            description: "Implemented OT-inspired optimistic concurrency for canvas elements, eliminating edit conflicts for teams of up to 50 simultaneous editors.",
            skills_used: "Elixir, OTP, Phoenix Channels, PostgreSQL"
          }
        ]
      },
      {
        company_name: "Beacon Health Platform",
        job_title: "Backend Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 3,
        start_date: "2020-04-01",
        end_date: "2022-09-30",
        description: "Built HIPAA-compliant Elixir/Phoenix APIs for a telehealth platform supporting 80K monthly patient sessions, including secure video session signaling.",
        projects: [
          {
            project_name: "Video Session Signaling Server",
            project_status: 1,
            start_date: "2020-09-01",
            end_date: "2021-04-30",
            description: "Built WebRTC signaling server using Phoenix Channels and GenServer state machines, enabling peer-to-peer video with sub-200ms connection establishment.",
            skills_used: "Elixir, Phoenix, OTP, WebRTC, PostgreSQL"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Northeastern University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2016-09-01",
        end_date: "2020-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 24. Sunita Kapoor — Technical Program Manager ─────────────────────────
  {
    email: "sunita.kapoor@example.com",
    full_name: "Sunita Kapoor",
    first_name: "Sunita",
    last_name: "Kapoor",
    phone: "+1-206-555-2401",
    city: "Seattle",
    state: "WA",
    country: "US",
    postal_code: "98109",
    current_title: "Senior Technical Program Manager",
    about_me: "Technical Program Manager with 8 years of experience driving complex, cross-functional engineering programs at cloud and consumer tech companies. Former software engineer with strong understanding of distributed systems and APIs. Skilled at creating clarity from ambiguity and keeping large programs on track.",
    linkedin_url: "https://linkedin.com/in/sunitakapoor-tpm",
    github_url: nil,
    skills: [
      { name: "Program Management",    category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Agile / Scrum",         category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "OKR Frameworks",        category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Python",                category: "Languages",      proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72,  skill_type: "Secondary", year_last_used: 2023 },
      { name: "SQL",                   category: "Databases",      proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72,  skill_type: "Secondary", year_last_used: 2024 },
      { name: "JIRA",                  category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",                   category: "Cloud & DevOps", proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24,  skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Risk Management",       category: "Other",          proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Git",                   category: "Source Control", proficiency: "Beginner",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60,  skill_type: "Tertiary",  year_last_used: 2024 }
    ],
    work_experiences: [
      {
        company_name: "CloudWave Inc",
        job_title: "Senior Technical Program Manager",
        work_status: 1,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 3,
        start_date: "2021-06-01",
        end_date: nil,
        description: "Leading cross-functional programs across 8 teams (60+ engineers) for a cloud data platform. Responsible for quarterly planning, dependency management, and executive communication for 3 flagship product initiatives.",
        projects: [
          {
            project_name: "Data Platform GA Launch",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-12-31",
            description: "Coordinated GA launch of a new cloud data platform across 8 engineering teams, 3 product managers, legal, and marketing — delivered on time with zero critical post-launch defects.",
            skills_used: "Program Management, JIRA, Agile, Risk Management, OKR Frameworks"
          },
          {
            project_name: "GDPR Compliance Program",
            project_status: 1,
            start_date: "2023-09-01",
            end_date: "2024-05-31",
            description: "Orchestrated company-wide GDPR data residency compliance program across 12 teams, meeting regulatory deadline 6 weeks ahead of schedule.",
            skills_used: "Program Management, Risk Management, JIRA, OKR Frameworks"
          }
        ]
      },
      {
        company_name: "ShopFast",
        job_title: "Technical Program Manager",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 1,
        start_date: "2018-04-01",
        end_date: "2021-05-31",
        description: "TPM for the checkout and payments infrastructure team at a high-growth e-commerce company. Drove quarterly planning and coordinated 6 major platform migrations.",
        projects: [
          {
            project_name: "Checkout Payments Modernization",
            project_status: 1,
            start_date: "2019-06-01",
            end_date: "2020-09-30",
            description: "Managed 15-month migration from legacy payment processor to Stripe, coordinating 4 engineering teams and ensuring zero revenue impact throughout cutover.",
            skills_used: "Program Management, Agile, JIRA, Risk Management"
          }
        ]
      },
      {
        company_name: "Infosys",
        job_title: "Software Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 1,
        start_date: "2016-01-01",
        end_date: "2018-03-31",
        description: "Java developer on enterprise integration projects before transitioning into program management.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "Indian Institute of Technology, Delhi",
        degree_obtained: "Bachelor of Technology",
        field_of_study: "Computer Science and Engineering",
        start_date: "2011-07-01",
        end_date: "2015-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Project Management Professional (PMP)",
        issuing_org: "Project Management Institute",
        issue_date: "2020-03-01",
        expiry_date: nil,
        skills_covered: "Project Planning, Risk Management, Stakeholder Management, Agile, Scrum"
      },
      {
        certificate_name: "Certified Scrum Master (CSM)",
        issuing_org: "Scrum Alliance",
        issue_date: "2019-07-01",
        expiry_date: "2023-07-01",
        skills_covered: "Scrum Framework, Sprint Planning, Retrospectives, Agile Coaching"
      }
    ]
  },

  # ── 25. Liam Chen — iOS Developer ────────────────────────────────────────
  {
    email: "liam.chen@example.com",
    full_name: "Liam Chen",
    first_name: "Liam",
    last_name: "Chen",
    phone: "+1-415-555-2501",
    city: "San Francisco",
    state: "CA",
    country: "US",
    postal_code: "94103",
    current_title: "Senior iOS Engineer",
    about_me: "iOS engineer with 5 years of experience shipping consumer apps with millions of downloads. Deep expertise in Swift and SwiftUI, with a strong focus on performance and accessibility. Contributed to 3 apps featured by Apple in the App Store.",
    linkedin_url: "https://linkedin.com/in/liamchen-ios",
    github_url: "https://github.com/liamchen-ios",
    skills: [
      { name: "Swift",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "SwiftUI",        category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "UIKit",          category: "Frontend",       proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Combine",        category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Core Data",      category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "XCTest",         category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Instruments",    category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "REST APIs",      category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Wellness App Co",
        job_title: "Senior iOS Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 2,
        start_date: "2022-08-01",
        end_date: nil,
        description: "Senior iOS engineer on a mindfulness and sleep tracking app with 4M+ downloads and an Apple Design Award nomination. Owns the audio playback engine, HealthKit integration, and widget extensions.",
        projects: [
          {
            project_name: "Live Activities Sleep Tracker",
            project_status: 1,
            start_date: "2022-10-01",
            end_date: "2023-04-30",
            description: "Built Live Activities-based sleep stage tracker using ActivityKit and HealthKit, increasing overnight app engagement by 38%.",
            skills_used: "Swift, SwiftUI, ActivityKit, HealthKit, Core Data"
          },
          {
            project_name: "Offline Audio Engine",
            project_status: 1,
            start_date: "2023-06-01",
            end_date: "2023-12-31",
            description: "Rewrote the audio playback layer with AVAudioEngine and background task management, reducing playback interruptions by 90% on poor connections.",
            skills_used: "Swift, AVAudioEngine, Combine, Core Data"
          }
        ]
      },
      {
        company_name: "Fintech Mobile Labs",
        job_title: "iOS Developer",
        work_status: 0,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 1,
        start_date: "2019-07-01",
        end_date: "2022-07-31",
        description: "iOS developer on a stock trading and portfolio app. Implemented real-time price streaming, custom charting with CoreGraphics, and biometric-secured login flows.",
        projects: [
          {
            project_name: "Real-time Price Charts",
            project_status: 1,
            start_date: "2020-04-01",
            end_date: "2020-10-31",
            description: "Built custom candlestick and sparkline charts with CoreGraphics and Metal, rendering 60fps updates on live market data for 300K+ active traders.",
            skills_used: "Swift, UIKit, CoreGraphics, Metal, WebSockets"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "UC San Diego",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Engineering",
        start_date: "2015-09-01",
        end_date: "2019-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 26. Nadia Okonkwo — MLOps Engineer ───────────────────────────────────
  {
    email: "nadia.okonkwo@example.com",
    full_name: "Nadia Okonkwo",
    first_name: "Nadia",
    last_name: "Okonkwo",
    phone: "+1-212-555-2601",
    city: "New York",
    state: "NY",
    country: "US",
    postal_code: "10013",
    current_title: "MLOps Engineer",
    about_me: "MLOps engineer with 4 years of experience bridging the gap between ML research and production systems. Builds reliable model training pipelines, deployment infrastructure, and observability tooling that lets data scientists ship 10x faster. Background in data science before transitioning to MLOps.",
    linkedin_url: "https://linkedin.com/in/nadiaokonkwo-mlops",
    github_url: "https://github.com/nokonkwo-mlops",
    skills: [
      { name: "Python",         category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "MLflow",         category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubeflow",       category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",     category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS SageMaker",  category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Docker",         category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Apache Airflow", category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Terraform",      category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "AdTech AI Corp",
        job_title: "Senior MLOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "New York, NY",
        location_type: 2,
        start_date: "2023-03-01",
        end_date: nil,
        description: "Building and operating the ML platform used by 25 data scientists to train, evaluate, and deploy 50+ production models. Reduced model deployment lead time from 3 weeks to 2 days.",
        projects: [
          {
            project_name: "Self-serve Model Deployment Platform",
            project_status: 1,
            start_date: "2023-05-01",
            end_date: "2024-01-31",
            description: "Built a Kubeflow-based self-serve platform with automated A/B traffic splitting, canary rollouts, and drift alerting, cutting deployment lead time by 85%.",
            skills_used: "Kubeflow, Kubernetes, MLflow, Python, Terraform, AWS"
          },
          {
            project_name: "Feature Store Implementation",
            project_status: 1,
            start_date: "2024-04-01",
            end_date: "2024-09-30",
            description: "Designed and implemented a centralized feature store on AWS using Feast, enabling feature reuse across 12 model teams and reducing duplicate feature engineering by 60%.",
            skills_used: "Feast, AWS S3, Redis, Python, Apache Airflow"
          }
        ]
      },
      {
        company_name: "HealthAI Systems",
        job_title: "MLOps / Data Scientist",
        work_status: 0,
        employment_type: 1,
        location: "New York, NY",
        location_type: 1,
        start_date: "2021-06-01",
        end_date: "2023-02-28",
        description: "Dual role as data scientist and MLOps engineer. Built and maintained clinical NLP model pipelines on AWS SageMaker, transitioning models from notebook experiments to production endpoints.",
        projects: [
          {
            project_name: "Clinical NLP Pipeline",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-09-30",
            description: "Built SageMaker Pipelines for training and deploying a clinical notes NER model at scale, cutting retraining time from 6 hours to 40 minutes.",
            skills_used: "AWS SageMaker, Python, MLflow, Docker, Hugging Face"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Columbia University",
        degree_obtained: "Master of Science",
        field_of_study: "Applied Mathematics",
        start_date: "2019-09-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      },
      {
        school_name: "University of Lagos",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Statistics",
        start_date: "2015-09-01",
        end_date: "2019-07-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Machine Learning - Specialty",
        issuing_org: "Amazon Web Services",
        issue_date: "2022-09-01",
        expiry_date: "2025-09-01",
        skills_covered: "SageMaker, ML Pipelines, Feature Engineering, Model Monitoring"
      }
    ]
  },

  # ── 27. Sebastian Müller — Go Backend Developer ───────────────────────────
  {
    email: "sebastian.muller@example.com",
    full_name: "Sebastian Müller",
    first_name: "Sebastian",
    last_name: "Müller",
    phone: "+1-312-555-2701",
    city: "Chicago",
    state: "IL",
    country: "US",
    postal_code: "60605",
    current_title: "Senior Go Backend Engineer",
    about_me: "Backend engineer with 5 years of experience writing idiomatic Go for high-throughput infrastructure and developer-facing APIs. Focused on simplicity, observability, and operational excellence. Open-source contributor with a library for distributed tracing middleware used by 500+ GitHub stars.",
    linkedin_url: "https://linkedin.com/in/sebastianmuller-go",
    github_url: "https://github.com/smuller-go",
    skills: [
      { name: "Go",             category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "gRPC",           category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PostgreSQL",     category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kafka",          category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redis",          category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Kubernetes",     category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",            category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "OpenTelemetry",  category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Transact API",
        job_title: "Senior Go Backend Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Chicago, IL",
        location_type: 2,
        start_date: "2022-05-01",
        end_date: nil,
        description: "Core engineer on a financial data aggregation API serving 300 fintech customers. Owns the gRPC service layer, Kafka event pipelines, and observability stack. Designed the rate-limiting and quota enforcement system from scratch.",
        projects: [
          {
            project_name: "gRPC Gateway Migration",
            project_status: 1,
            start_date: "2022-08-01",
            end_date: "2023-04-30",
            description: "Migrated REST-only external API to gRPC with a grpc-gateway JSON proxy, reducing serialization overhead by 45% and improving SDK generation quality.",
            skills_used: "Go, gRPC, protobuf, PostgreSQL, Kubernetes"
          },
          {
            project_name: "Distributed Rate Limiter",
            project_status: 1,
            start_date: "2023-08-01",
            end_date: "2024-02-28",
            description: "Built a sliding-window rate limiter with Redis and atomic Lua scripts supporting 50K rps with <1ms overhead, released as open-source middleware.",
            skills_used: "Go, Redis, OpenTelemetry, Kubernetes"
          }
        ]
      },
      {
        company_name: "DevTools Inc",
        job_title: "Backend Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Chicago, IL",
        location_type: 3,
        start_date: "2019-09-01",
        end_date: "2022-04-30",
        description: "Backend engineer on a CI/CD platform running 2M+ build jobs monthly. Built job scheduling, artifact storage, and webhook delivery services in Go.",
        projects: [
          {
            project_name: "Webhook Delivery Service",
            project_status: 1,
            start_date: "2020-05-01",
            end_date: "2020-12-31",
            description: "Built an at-least-once webhook delivery service with exponential backoff, dead-letter queuing, and per-endpoint circuit breakers handling 5M events/day.",
            skills_used: "Go, Kafka, PostgreSQL, Redis, AWS"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Illinois Chicago",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2015-08-01",
        end_date: "2019-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 28. Anya Petrova — Embedded Systems Engineer ──────────────────────────
  {
    email: "anya.petrova@example.com",
    full_name: "Anya Petrova",
    first_name: "Anya",
    last_name: "Petrova",
    phone: "+1-503-555-2801",
    city: "Portland",
    state: "OR",
    country: "US",
    postal_code: "97209",
    current_title: "Embedded Systems Engineer",
    about_me: "Embedded systems engineer with 6 years of experience developing firmware for IoT devices, medical hardware, and industrial control systems. Expert in C/C++ real-time programming and low-level hardware interfacing. Holds 2 patents in sensor fusion algorithms.",
    linkedin_url: "https://linkedin.com/in/anyapetrova-embedded",
    github_url: "https://github.com/apetrova-fw",
    skills: [
      { name: "C",              category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "C++",            category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "RTOS",           category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "ARM Cortex-M",   category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Python",         category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "CAN Bus",        category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "BLE / Bluetooth",category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "GDB / JTAG",     category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "BioSense Medical Devices",
        job_title: "Embedded Systems Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Portland, OR",
        location_type: 1,
        start_date: "2021-10-01",
        end_date: nil,
        description: "Developing firmware for FDA Class II continuous glucose monitoring devices worn by 80K+ patients. Writing real-time C code for ARM Cortex-M4 MCUs with strict power and safety requirements.",
        projects: [
          {
            project_name: "Sensor Fusion Algorithm",
            project_status: 1,
            start_date: "2022-02-01",
            end_date: "2023-01-31",
            description: "Developed a Kalman filter-based glucose sensor fusion algorithm achieving ±8% MARD accuracy across 14-day wear, resulting in 2 granted patents.",
            skills_used: "C, ARM Cortex-M4, RTOS, Python (testing), MATLAB"
          },
          {
            project_name: "BLE Data Streaming Layer",
            project_status: 1,
            start_date: "2023-05-01",
            end_date: "2023-11-30",
            description: "Implemented BLE 5.0 data streaming with custom GATT profile and lossless packet reassembly, enabling real-time glucose readings on companion iOS/Android apps.",
            skills_used: "C, BLE / Bluetooth, ARM Cortex-M, RTOS"
          }
        ]
      },
      {
        company_name: "AutoEdge Systems",
        job_title: "Junior Embedded Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Detroit, MI",
        location_type: 1,
        start_date: "2018-08-01",
        end_date: "2021-09-30",
        description: "Firmware engineer for automotive ECU software. Developed CAN Bus communication stacks and AUTOSAR-compliant drivers for powertrain control modules.",
        projects: [
          {
            project_name: "CAN Gateway Driver",
            project_status: 1,
            start_date: "2019-06-01",
            end_date: "2020-03-31",
            description: "Implemented an AUTOSAR-compliant CAN gateway driver routing 500+ message IDs across 4 vehicle networks, used in a production model line of 200K vehicles/year.",
            skills_used: "C, CAN Bus, AUTOSAR, ARM Cortex-M, GDB / JTAG"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Oregon State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Electrical and Computer Engineering",
        start_date: "2014-09-01",
        end_date: "2018-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 29. Marcus Williams — Python / Django Backend Developer ───────────────
  {
    email: "marcus.williams@example.com",
    full_name: "Marcus Williams",
    first_name: "Marcus",
    last_name: "Williams",
    phone: "+1-404-555-2901",
    city: "Atlanta",
    state: "GA",
    country: "US",
    postal_code: "30303",
    current_title: "Backend Engineer (Python / Django)",
    about_me: "Python backend engineer with 4 years of experience building APIs and data-intensive services with Django and FastAPI. Strong focus on database performance and API design. Experience in e-commerce, logistics, and healthcare SaaS.",
    linkedin_url: "https://linkedin.com/in/marcuswilliams-py",
    github_url: "https://github.com/mwilliams-backend",
    skills: [
      { name: "Python",       category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Django",       category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "FastAPI",      category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PostgreSQL",   category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Celery",       category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Redis",        category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",       category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "pytest",       category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",          category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "MedBilling Pro",
        job_title: "Backend Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Atlanta, GA",
        location_type: 2,
        start_date: "2023-05-01",
        end_date: nil,
        description: "Building Django REST APIs for a healthcare billing SaaS serving 400+ medical practices. Owns the claims processing pipeline and insurance verification integrations.",
        projects: [
          {
            project_name: "Claims Processing Engine",
            project_status: 1,
            start_date: "2023-07-01",
            end_date: "2024-02-28",
            description: "Redesigned the HIPAA 837 claims submission pipeline with Celery task queues and dead-letter handling, reducing claims failure rate from 12% to 0.8%.",
            skills_used: "Python, Django, Celery, PostgreSQL, Redis"
          },
          {
            project_name: "Insurance Eligibility API",
            project_status: 1,
            start_date: "2024-04-01",
            end_date: "2024-08-31",
            description: "Built FastAPI service integrating 6 insurance clearinghouses for real-time eligibility checks, reducing front-desk manual verifications by 70%.",
            skills_used: "FastAPI, Python, PostgreSQL, Docker"
          }
        ]
      },
      {
        company_name: "ShipTrack Logistics",
        job_title: "Junior Python Developer",
        work_status: 0,
        employment_type: 1,
        location: "Atlanta, GA",
        location_type: 1,
        start_date: "2021-01-01",
        end_date: "2023-04-30",
        description: "Built and maintained Django APIs for a last-mile delivery tracking platform. Handled route optimization API integrations and driver mobile app backend.",
        projects: [
          {
            project_name: "Driver Dispatch API",
            project_status: 1,
            start_date: "2021-08-01",
            end_date: "2022-03-31",
            description: "Built a geofence-based driver dispatch API with PostGIS and Django, reducing average package pickup wait time from 18 minutes to 7 minutes.",
            skills_used: "Python, Django, PostgreSQL, PostGIS, Redis"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Georgia State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 30. Yuki Tanaka — Computer Vision Engineer ────────────────────────────
  {
    email: "yuki.tanaka@example.com",
    full_name: "Yuki Tanaka",
    first_name: "Yuki",
    last_name: "Tanaka",
    phone: "+1-206-555-3001",
    city: "Seattle",
    state: "WA",
    country: "US",
    postal_code: "98105",
    current_title: "Computer Vision Engineer",
    about_me: "Computer vision engineer with 4 years of experience developing real-time image and video analysis systems for retail, autonomous vehicles, and manufacturing quality control. Expert in object detection, tracking, and edge deployment of CV models.",
    linkedin_url: "https://linkedin.com/in/yukitanaka-cv",
    github_url: "https://github.com/ytanaka-cv",
    skills: [
      { name: "Python",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PyTorch",         category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "OpenCV",          category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "YOLO",            category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TensorRT",        category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "CUDA",            category: "Other",          proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "FastAPI",         category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "RetailSense AI",
        job_title: "Computer Vision Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 2,
        start_date: "2022-11-01",
        end_date: nil,
        description: "Building real-time CV systems for retail loss prevention and shopper analytics deployed across 1,200 stores. Develops and optimizes object detection and people-counting models running on edge devices.",
        projects: [
          {
            project_name: "Edge Object Detection Pipeline",
            project_status: 1,
            start_date: "2023-01-01",
            end_date: "2023-09-30",
            description: "Optimized YOLOv8 models with TensorRT for Jetson Orin edge devices, achieving 45fps real-time inference on 4K streams while reducing compute cost by 60%.",
            skills_used: "PyTorch, YOLO, TensorRT, CUDA, Python"
          },
          {
            project_name: "Shopper Dwell Time Tracker",
            project_status: 1,
            start_date: "2024-01-01",
            end_date: "2024-06-30",
            description: "Built a multi-camera DeepSORT-based tracking system for measuring shopper dwell time at shelf, delivering insights that improved store layout revenue by 8%.",
            skills_used: "Python, OpenCV, PyTorch, DeepSORT, FastAPI"
          }
        ]
      },
      {
        company_name: "Autonomy Research Lab",
        job_title: "Junior CV Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 1,
        start_date: "2020-09-01",
        end_date: "2022-10-31",
        description: "Research and engineering on perception systems for autonomous vehicle prototypes. Developed lane detection and obstacle segmentation models.",
        projects: [
          {
            project_name: "LiDAR-Camera Fusion",
            project_status: 1,
            start_date: "2021-03-01",
            end_date: "2021-10-31",
            description: "Implemented early-fusion LiDAR-camera obstacle detection pipeline, improving 3D bounding box mAP from 0.61 to 0.78 on the KITTI benchmark.",
            skills_used: "Python, PyTorch, OpenCV, CUDA, ROS"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Washington",
        degree_obtained: "Master of Science",
        field_of_study: "Computer Science (Computer Vision focus)",
        start_date: "2018-09-01",
        end_date: "2020-08-31",
        still_studying: false,
        description: "Thesis: Self-supervised depth estimation for autonomous driving"
      },
      {
        school_name: "Waseda University",
        degree_obtained: "Bachelor of Engineering",
        field_of_study: "Electronics and Information Systems",
        start_date: "2014-04-01",
        end_date: "2018-03-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 31. Elena Vasquez — Developer Advocate / Technical Writer ─────────────
  {
    email: "elena.vasquez@example.com",
    full_name: "Elena Vasquez",
    first_name: "Elena",
    last_name: "Vasquez",
    phone: "+1-737-555-3101",
    city: "Austin",
    state: "TX",
    country: "US",
    postal_code: "78703",
    current_title: "Senior Developer Advocate",
    about_me: "Developer advocate with 5 years of experience helping engineering teams understand and adopt developer tools, APIs, and open-source projects. Former backend engineer. Creates technical content including tutorials, sample apps, and conference talks. Speaker at 12+ conferences including KubeCon, PyCon, and DevRelCon.",
    linkedin_url: "https://linkedin.com/in/elenavasquez-devrel",
    github_url: "https://github.com/evasquez-devrel",
    skills: [
      { name: "Python",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TypeScript",      category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Technical Writing",category: "Other",         proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "REST APIs",       category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Docker",          category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Node.js",         category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Public Speaking",  category: "Other",         proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "OpenInfra Foundation",
        job_title: "Senior Developer Advocate",
        work_status: 1,
        employment_type: 1,
        location: "Austin, TX",
        location_type: 2,
        start_date: "2022-01-01",
        end_date: nil,
        description: "Developer advocate for an open-source cloud infrastructure project with 18K GitHub stars. Creates tutorials and sample apps, manages community on Discord and GitHub, and speaks at 6+ conferences per year.",
        projects: [
          {
            project_name: "Getting Started Tutorial Series",
            project_status: 1,
            start_date: "2022-03-01",
            end_date: "2022-09-30",
            description: "Produced a 10-part getting-started video and written tutorial series that became the #1 traffic source for the docs site, reducing support questions by 40%.",
            skills_used: "Technical Writing, Python, Docker, Kubernetes, Node.js"
          },
          {
            project_name: "Community SDK Examples Repo",
            project_status: 1,
            start_date: "2023-04-01",
            end_date: "2023-10-31",
            description: "Built and maintained 25 working SDK example apps in 6 languages, which contributors and community members expanded to 60 examples with 2K+ GitHub stars.",
            skills_used: "Python, TypeScript, Node.js, REST APIs, Git"
          }
        ]
      },
      {
        company_name: "DevTools Startup",
        job_title: "Developer Advocate",
        work_status: 0,
        employment_type: 1,
        location: "Austin, TX",
        location_type: 3,
        start_date: "2019-10-01",
        end_date: "2021-12-31",
        description: "First developer advocate hire for a developer productivity tool. Grew developer community from 500 to 12,000 members through content, events, and partnerships.",
        projects: [
          {
            project_name: "Developer Community Growth",
            project_status: 1,
            start_date: "2020-01-01",
            end_date: "2021-06-30",
            description: "Launched developer newsletter, monthly live coding sessions, and an ambassador program that organically grew community to 12K developers across 40 countries.",
            skills_used: "Technical Writing, Public Speaking, Python, REST APIs"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Texas at Austin",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2015-08-01",
        end_date: "2019-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: []
  },

  # ── 33. Jordan Ramirez — Platform / DevOps Engineer ──────────────────────────
  {
    email: "jordan.ramirez@example.com",
    full_name: "Jordan Ramirez",
    first_name: "Jordan",
    last_name: "Ramirez",
    phone: "+1-512-555-3301",
    city: "Denver",
    state: "CO",
    country: "US",
    postal_code: "80202",
    current_title: "Platform Engineer",
    about_me: "Platform engineer with 5 years of experience building internal developer platforms and golden paths that let product engineers ship faster and safer. Deep expertise in ArgoCD, Backstage, and GitOps workflows. Reduced mean time to onboard a new service from 3 days to 2 hours at my current company.",
    linkedin_url: "https://linkedin.com/in/jordanramirez-platform",
    github_url: "https://github.com/jramirez-platform",
    skills: [
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "ArgoCD",          category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Backstage",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Primary",   year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Helm",            category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",          category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Go",              category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Crossplane",      category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "FinData Corp",
        job_title: "Platform Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Denver, CO",
        location_type: 2,
        start_date: "2023-02-01",
        end_date: nil,
        description: "Building and operating the internal developer platform for 180 engineers across 12 product teams. Owns the GitOps workflow, service catalog, and self-service infrastructure provisioning layer. Reduced service onboarding time from 3 days to 2 hours.",
        projects: [
          {
            project_name: "Internal Developer Portal (Backstage)",
            project_status: 1,
            start_date: "2023-04-01",
            end_date: "2024-01-31",
            description: "Deployed and customized Backstage with 8 internal plugins including a service catalog, TechDocs integration, and a self-service K8s namespace provisioner used by all 180 engineers.",
            skills_used: "Backstage, TypeScript, Kubernetes, ArgoCD, Terraform"
          },
          {
            project_name: "GitOps Migration",
            project_status: 1,
            start_date: "2024-03-01",
            end_date: "2024-10-31",
            description: "Migrated 60 services from imperative kubectl deployments to ArgoCD ApplicationSets with automated drift detection, reducing failed deployments by 75%.",
            skills_used: "ArgoCD, Helm, Kubernetes, GitHub Actions, Python"
          }
        ]
      },
      {
        company_name: "CloudNative Agency",
        job_title: "DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Denver, CO",
        location_type: 3,
        start_date: "2021-01-01",
        end_date: "2023-01-31",
        description: "Designed and implemented cloud infrastructure and CI/CD pipelines for 8 client startups on AWS. Standardized Terraform module library adopted across all client accounts.",
        projects: [
          {
            project_name: "Shared Terraform Module Library",
            project_status: 1,
            start_date: "2021-06-01",
            end_date: "2022-03-31",
            description: "Built a reusable library of 25 Terraform modules covering EKS, RDS, S3, and IAM patterns, reducing new client environment setup from 2 weeks to 2 days.",
            skills_used: "Terraform, AWS, Kubernetes, GitHub Actions"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Colorado State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Certified Kubernetes Administrator (CKA)",
        issuing_org: "Cloud Native Computing Foundation",
        issue_date: "2022-07-01",
        expiry_date: "2025-07-01",
        skills_covered: "Kubernetes, Container Orchestration, Networking, Security, Storage"
      },
      {
        certificate_name: "HashiCorp Certified: Terraform Associate",
        issuing_org: "HashiCorp",
        issue_date: "2022-03-01",
        expiry_date: "2025-03-01",
        skills_covered: "Terraform, IaC, State Management, Modules, Providers"
      }
    ]
  },

  # ── 34. Maya Singh — DevSecOps Engineer ──────────────────────────────────────
  {
    email: "maya.singh@example.com",
    full_name: "Maya Singh",
    first_name: "Maya",
    last_name: "Singh",
    phone: "+1-571-555-3401",
    city: "Arlington",
    state: "VA",
    country: "US",
    postal_code: "22201",
    current_title: "Senior DevSecOps Engineer",
    about_me: "DevSecOps engineer with 6 years of experience embedding security into CI/CD pipelines and cloud infrastructure. Expert in supply chain security, secrets management, and policy-as-code with Open Policy Agent. Former penetration tester turned builder — I break things so I know how to harden them.",
    linkedin_url: "https://linkedin.com/in/mayasingh-devsecops",
    github_url: "https://github.com/msingh-sec",
    skills: [
      { name: "AWS",                  category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Open Policy Agent",    category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Vault",                category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",            category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",               category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bash",                 category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "GitHub Actions",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "SAST / DAST",          category: "Testing",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",                  category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "GovTech Solutions",
        job_title: "Senior DevSecOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Arlington, VA",
        location_type: 3,
        start_date: "2022-09-01",
        end_date: nil,
        description: "Leading DevSecOps practice for federal government cloud modernization programs. Implementing supply chain security, policy-as-code guardrails, and secrets management across 25 engineering teams in FedRAMP-compliant environments.",
        projects: [
          {
            project_name: "Supply Chain Security Program",
            project_status: 1,
            start_date: "2023-01-01",
            end_date: "2023-10-31",
            description: "Implemented SLSA Level 3 supply chain controls with Sigstore/Cosign image signing, SBOM generation, and Snyk SCA scanning across 80 repositories, achieving FedRAMP High compliance for artifact integrity.",
            skills_used: "GitHub Actions, Sigstore, Snyk, Python, AWS ECR"
          },
          {
            project_name: "Policy-as-Code Guardrails",
            project_status: 1,
            start_date: "2024-02-01",
            end_date: "2024-09-30",
            description: "Deployed OPA Gatekeeper with 35 custom constraint templates across all EKS clusters, enforcing pod security standards, resource limits, and approved image registries with zero manual review overhead.",
            skills_used: "Open Policy Agent, Kubernetes, Terraform, Rego, AWS"
          }
        ]
      },
      {
        company_name: "CyberDefend Inc",
        job_title: "DevSecOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Washington, DC",
        location_type: 1,
        start_date: "2019-07-01",
        end_date: "2022-08-31",
        description: "Integrated security tooling into CI/CD pipelines for financial services clients and managed centralized Vault secrets infrastructure serving 500+ applications.",
        projects: [
          {
            project_name: "Vault Secrets Platform",
            project_status: 1,
            start_date: "2020-03-01",
            end_date: "2021-01-31",
            description: "Deployed highly available HashiCorp Vault cluster on AWS with dynamic secrets for RDS, Kubernetes service account auth, and automated certificate lifecycle — replacing 500+ hardcoded credentials.",
            skills_used: "Vault, AWS, Kubernetes, Terraform, Python"
          },
          {
            project_name: "Shift-left SAST Integration",
            project_status: 1,
            start_date: "2021-04-01",
            end_date: "2022-01-31",
            description: "Rolled out Semgrep custom rules and mandatory SAST gating across 30 client repos, catching 180+ injection and auth vulnerabilities before they reached staging.",
            skills_used: "Semgrep, SAST / DAST, GitHub Actions, Python, Bash"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "George Mason University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Cybersecurity Engineering",
        start_date: "2015-08-01",
        end_date: "2019-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Security - Specialty",
        issuing_org: "Amazon Web Services",
        issue_date: "2023-04-01",
        expiry_date: "2026-04-01",
        skills_covered: "IAM, KMS, GuardDuty, Security Hub, CloudTrail, VPC Security"
      },
      {
        certificate_name: "Certified Kubernetes Security Specialist (CKS)",
        issuing_org: "Cloud Native Computing Foundation",
        issue_date: "2023-09-01",
        expiry_date: "2025-09-01",
        skills_covered: "Kubernetes Security, Pod Security, Network Policies, RBAC, Secrets"
      }
    ]
  },

  # ── 35. Chris Park — Generative AI / LLM Engineer ─────────────────────────
  {
    email: "chris.park@example.com",
    full_name: "Chris Park",
    first_name: "Chris",
    last_name: "Park",
    phone: "+1-628-555-3501",
    city: "San Francisco",
    state: "CA",
    country: "US",
    postal_code: "94103",
    current_title: "Senior Generative AI Engineer",
    about_me: "Generative AI engineer with 4 years of experience building production LLM applications and agentic systems. Deep expertise in prompt engineering, RAG, function calling, and LLM evaluation. Previously shipped a customer-facing AI assistant handling 2M queries/month. Passionate about making LLMs reliable and measurable in production.",
    linkedin_url: "https://linkedin.com/in/chrispark-ai",
    github_url: "https://github.com/cpark-genai",
    skills: [
      { name: "Python",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "OpenAI API",      category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "LangChain",       category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "LangGraph",       category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Primary",   year_last_used: 2026 },
      { name: "pgvector",        category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Anthropic API",   category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "FastAPI",         category: "Backend",        proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Prompt Engineering", category: "AI & LLM Tools", proficiency: "Advanced", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Redis",           category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Aria AI",
        job_title: "Senior Generative AI Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 2,
        start_date: "2024-01-01",
        end_date: nil,
        description: "Building multi-agent AI workflows for an enterprise knowledge management platform. Owns the LLM orchestration layer, evaluation pipeline, and prompt versioning system serving 2M+ queries per month.",
        projects: [
          {
            project_name: "Multi-agent Research Assistant",
            project_status: 1,
            start_date: "2024-02-01",
            end_date: "2024-09-30",
            description: "Designed a LangGraph-based multi-agent system with specialized sub-agents for web search, document analysis, and synthesis — reducing research task completion time by 60% vs. single-agent baseline.",
            skills_used: "LangGraph, LangChain, OpenAI API, Anthropic API, Python, FastAPI"
          },
          {
            project_name: "LLM Evaluation Framework",
            project_status: 1,
            start_date: "2024-10-01",
            end_date: nil,
            description: "Built an automated LLM evaluation harness using LLM-as-judge with adversarial test sets covering hallucination, faithfulness, and task completion — enabling weekly regression testing across model upgrades.",
            skills_used: "Python, OpenAI API, Anthropic API, PostgreSQL, FastAPI"
          }
        ]
      },
      {
        company_name: "Nexus SaaS",
        job_title: "AI Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 3,
        start_date: "2022-05-01",
        end_date: "2023-12-31",
        description: "Shipped the company's first AI-powered features including a natural language query interface and an auto-tagging system for a B2B content platform with 400K users.",
        projects: [
          {
            project_name: "Natural Language Query Interface",
            project_status: 1,
            start_date: "2022-08-01",
            end_date: "2023-04-30",
            description: "Built a text-to-SQL interface using GPT-4 with dynamic schema context injection and query validation, enabling non-technical users to query structured data — adopted by 35% of enterprise customers.",
            skills_used: "OpenAI API, LangChain, Python, PostgreSQL, FastAPI"
          }
        ]
      },
      {
        company_name: "DataBot Inc",
        job_title: "ML Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Jose, CA",
        location_type: 1,
        start_date: "2020-07-01",
        end_date: "2022-04-30",
        description: "Developed NLP models for email classification and intent detection pipelines processing 5M messages/day.",
        projects: [
          {
            project_name: "Email Intent Classifier",
            project_status: 1,
            start_date: "2020-10-01",
            end_date: "2021-07-31",
            description: "Fine-tuned BERT-based email intent classifier achieving 94.2% accuracy across 18 intent classes, replacing a rules-based system that topped out at 71%.",
            skills_used: "Python, Hugging Face Transformers, PyTorch, FastAPI, Redis"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Carnegie Mellon University",
        degree_obtained: "Master of Science",
        field_of_study: "Language Technologies",
        start_date: "2018-08-01",
        end_date: "2020-05-31",
        still_studying: false,
        description: "Thesis: Dialogue state tracking for task-oriented conversational agents"
      },
      {
        school_name: "University of California, Los Angeles",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2014-09-01",
        end_date: "2018-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "DeepLearning.AI LangChain for LLM Application Development",
        issuing_org: "DeepLearning.AI",
        issue_date: "2023-06-01",
        expiry_date: nil,
        skills_covered: "LangChain, RAG, Agents, Memory, Output Parsers, LLM Chaining"
      }
    ]
  },

  # ── 36. Fatima Al-Hassan — ML Platform Engineer ───────────────────────────
  {
    email: "fatima.alhassan@example.com",
    full_name: "Fatima Al-Hassan",
    first_name: "Fatima",
    last_name: "Al-Hassan",
    phone: "+1-206-555-3601",
    city: "Seattle",
    state: "WA",
    country: "US",
    postal_code: "98109",
    current_title: "ML Platform Engineer",
    about_me: "ML Platform engineer with 5 years of experience building the infrastructure that data scientists and ML engineers rely on to train, evaluate, and deploy models at scale. Expert in feature stores, model registries, training pipelines, and ML observability. Reduced model deployment lead time from 3 weeks to 4 hours at my current org.",
    linkedin_url: "https://linkedin.com/in/fatimaalhassan-ml",
    github_url: "https://github.com/falhassan-mlp",
    skills: [
      { name: "Python",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubeflow",        category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "MLflow",          category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Feast",           category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Apache Spark",    category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Terraform",       category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "PyTorch",         category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "RetailAI Co",
        job_title: "ML Platform Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 2,
        start_date: "2022-10-01",
        end_date: nil,
        description: "Building and owning the ML platform used by 60 data scientists across recommendation, pricing, and fraud teams. Manages the feature store, model registry, online serving infrastructure, and automated retraining pipelines processing 800GB of training data daily.",
        projects: [
          {
            project_name: "Real-time Feature Store",
            project_status: 1,
            start_date: "2023-02-01",
            end_date: "2023-11-30",
            description: "Deployed Feast-backed feature store with Redis online store and S3 offline store, enabling consistent feature computation between training and serving and eliminating 3 categories of training-serving skew incidents.",
            skills_used: "Feast, Redis, AWS S3, Apache Spark, Python, Kubernetes"
          },
          {
            project_name: "Automated Model Retraining Pipeline",
            project_status: 1,
            start_date: "2024-03-01",
            end_date: "2024-10-31",
            description: "Built a Kubeflow Pipelines-based retraining system with data drift detection triggers and automated A/B canary rollouts, reducing model deployment lead time from 3 weeks to 4 hours.",
            skills_used: "Kubeflow, MLflow, Python, Kubernetes, AWS SageMaker, Terraform"
          }
        ]
      },
      {
        company_name: "AdTech Platform",
        job_title: "MLOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 3,
        start_date: "2020-02-01",
        end_date: "2022-09-30",
        description: "Managed end-to-end ML lifecycle for a real-time bidding platform running 20 production models. Built model monitoring dashboards and standardized experiment tracking using MLflow.",
        projects: [
          {
            project_name: "ML Experiment Tracking Rollout",
            project_status: 1,
            start_date: "2020-06-01",
            end_date: "2021-03-31",
            description: "Deployed centralized MLflow tracking server with S3 artifact storage, standardizing experiment logging across 8 data science teams and reducing model reproducibility issues by 90%.",
            skills_used: "MLflow, AWS, Python, Docker, PostgreSQL"
          },
          {
            project_name: "Model Performance Monitoring",
            project_status: 1,
            start_date: "2021-06-01",
            end_date: "2022-03-31",
            description: "Built a feature and prediction drift monitoring system using Evidently AI with PagerDuty alerting, catching 5 model degradation events before they affected revenue.",
            skills_used: "Python, Evidently AI, Grafana, Prometheus, Kubernetes"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Washington",
        degree_obtained: "Master of Science",
        field_of_study: "Data Science",
        start_date: "2018-09-01",
        end_date: "2020-06-30",
        still_studying: false,
        description: "Thesis: Scalable feature pipelines for real-time machine learning inference"
      },
      {
        school_name: "American University of Beirut",
        degree_obtained: "Bachelor of Engineering",
        field_of_study: "Computer and Communications Engineering",
        start_date: "2014-09-01",
        end_date: "2018-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Machine Learning - Specialty",
        issuing_org: "Amazon Web Services",
        issue_date: "2023-09-01",
        expiry_date: "2026-09-01",
        skills_covered: "AWS SageMaker, Feature Engineering, Model Training, Model Deployment, ML Monitoring"
      }
    ]
  },

  # ── 32. Patrick Nguyen — Database Engineer / DBA ──────────────────────────
  {
    email: "patrick.nguyen@example.com",
    full_name: "Patrick Nguyen",
    first_name: "Patrick",
    last_name: "Nguyen",
    phone: "+1-713-555-3201",
    city: "Houston",
    state: "TX",
    country: "US",
    postal_code: "77005",
    current_title: "Senior Database Engineer",
    about_me: "Database engineer and DBA with 7 years of experience designing, tuning, and operating large-scale PostgreSQL, MySQL, and cloud-managed databases. Specializes in query optimization, replication strategies, and zero-downtime schema migrations for high-traffic production systems.",
    linkedin_url: "https://linkedin.com/in/patricknguyen-dba",
    github_url: "https://github.com/pnguyen-db",
    skills: [
      { name: "PostgreSQL",    category: "Databases",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "MySQL",         category: "Databases",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2025 },
      { name: "SQL",           category: "Databases",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "AWS RDS / Aurora", category: "Cloud & DevOps", proficiency: "Advanced",  years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Redis",         category: "Databases",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",        category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Terraform",     category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bash",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",           category: "Source Control", proficiency: "Intermediate", years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Commerce Platform Co",
        job_title: "Senior Database Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Houston, TX",
        location_type: 3,
        start_date: "2021-07-01",
        end_date: nil,
        description: "Database engineer for an e-commerce platform processing 80M transactions/month on Aurora PostgreSQL. Owns database performance, availability, and schema change processes across 40+ microservices.",
        projects: [
          {
            project_name: "Query Performance Overhaul",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-08-31",
            description: "Profiled and rewrote the 30 slowest production queries, reducing overall database CPU by 38% and eliminating all queries over 2s p99.",
            skills_used: "PostgreSQL, SQL, pg_stat_statements, EXPLAIN ANALYZE"
          },
          {
            project_name: "Zero-downtime Migration Framework",
            project_status: 1,
            start_date: "2023-03-01",
            end_date: "2023-09-30",
            description: "Designed a shadow-table migration pattern using pg_logical replication for zero-downtime schema changes on tables with 500M+ rows, adopted by all 40 teams.",
            skills_used: "PostgreSQL, pg_logical, Python, Bash, Terraform"
          }
        ]
      },
      {
        company_name: "SaaS Analytics Corp",
        job_title: "Database Administrator",
        work_status: 0,
        employment_type: 1,
        location: "Houston, TX",
        location_type: 1,
        start_date: "2017-09-01",
        end_date: "2021-06-30",
        description: "DBA for a multi-tenant analytics SaaS on MySQL and early PostgreSQL. Managed replication, backups, and performance across 200+ tenant databases.",
        projects: [
          {
            project_name: "MySQL to Aurora Migration",
            project_status: 1,
            start_date: "2019-04-01",
            end_date: "2020-01-31",
            description: "Migrated 200+ MySQL 5.7 databases to Aurora MySQL with DMS, achieving zero data loss and <10 minute total downtime per tenant during cutover.",
            skills_used: "MySQL, AWS RDS / Aurora, AWS DMS, Python, Bash"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Rice University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2013-08-01",
        end_date: "2017-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Database - Specialty",
        issuing_org: "Amazon Web Services",
        issue_date: "2022-05-01",
        expiry_date: "2025-05-01",
        skills_covered: "Aurora, RDS, DynamoDB, ElastiCache, Database Migration Service"
      }
    ]
  },

  # ── 37. Owen Fletcher — Junior DevOps Engineer ───────────────────────────
  {
    email: "owen.fletcher@example.com",
    full_name: "Owen Fletcher",
    first_name: "Owen",
    last_name: "Fletcher",
    phone: "+1-615-555-3701",
    city: "Nashville",
    state: "TN",
    country: "US",
    postal_code: "37201",
    current_title: "Junior DevOps Engineer",
    about_me: "Junior DevOps engineer with 1.5 years of experience supporting CI/CD pipelines and cloud infrastructure on AWS. Background in system administration. Eager to deepen expertise in Kubernetes and infrastructure-as-code.",
    linkedin_url: "https://linkedin.com/in/owenfletcher-devops",
    github_url: "https://github.com/ofletcher-ops",
    skills: [
      { name: "AWS",            category: "Cloud & DevOps", proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Docker",         category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Primary",   year_last_used: 2026 },
      { name: "GitHub Actions", category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 15, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Bash",           category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Linux",          category: "Other",          proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Terraform",      category: "Cloud & DevOps", proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 8,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",         category: "Languages",      proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 12, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",            category: "Source Control", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "MidState Software",
        job_title: "Junior DevOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Nashville, TN",
        location_type: 1,
        start_date: "2024-10-01",
        end_date: nil,
        description: "Supporting CI/CD pipelines and AWS infrastructure for a SaaS product team of 20 engineers. Maintaining GitHub Actions workflows, managing EC2 and S3 resources, and assisting with Terraform modules.",
        projects: [
          {
            project_name: "Pipeline Reliability Improvements",
            project_status: 1,
            start_date: "2025-01-01",
            end_date: "2025-04-30",
            description: "Identified and fixed 12 flaky pipeline steps causing intermittent build failures, reducing CI failure rate from 18% to 4%.",
            skills_used: "GitHub Actions, Docker, Bash, AWS"
          }
        ]
      },
      {
        company_name: "InfoSys Corp",
        job_title: "Systems Administrator",
        work_status: 0,
        employment_type: 1,
        location: "Nashville, TN",
        location_type: 1,
        start_date: "2022-06-01",
        end_date: "2024-09-30",
        description: "Managed on-premise Linux servers, user provisioning, and backup systems for a 300-person company. Began automating routine tasks with Bash and Python scripts.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "Middle Tennessee State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Information Technology",
        start_date: "2018-08-01",
        end_date: "2022-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Cloud Practitioner",
        issuing_org: "Amazon Web Services",
        issue_date: "2024-06-01",
        expiry_date: "2027-06-01",
        skills_covered: "AWS Core Services, Cloud Fundamentals, Billing, Security Basics"
      }
    ]
  },

  # ── 38. Valentina Cruz — Mid-level DevOps Engineer (GCP / Ansible) ────────
  {
    email: "valentina.cruz@example.com",
    full_name: "Valentina Cruz",
    first_name: "Valentina",
    last_name: "Cruz",
    phone: "+1-415-555-3801",
    city: "San Francisco",
    state: "CA",
    country: "US",
    postal_code: "94110",
    current_title: "DevOps Engineer",
    about_me: "DevOps engineer with 3 years of experience managing GCP infrastructure and automating configuration management with Ansible. Comfortable with the full deployment lifecycle from infrastructure provisioning to production monitoring. Currently deepening Kubernetes skills.",
    linkedin_url: "https://linkedin.com/in/valentinacruz-devops",
    github_url: "https://github.com/vcruz-devops",
    skills: [
      { name: "GCP",              category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Ansible",          category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",        category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Docker",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Kubernetes",       category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",           category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bash",             category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "GitLab CI",        category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Prometheus",       category: "Other",          proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 12, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",              category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "BioTrack Systems",
        job_title: "DevOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 2,
        start_date: "2023-05-01",
        end_date: nil,
        description: "Managing GCP infrastructure and GitLab CI pipelines for a healthcare data platform serving 80 hospital networks. Standardized configuration management with Ansible across 200+ GCE instances.",
        projects: [
          {
            project_name: "Ansible Configuration Standardization",
            project_status: 1,
            start_date: "2023-08-01",
            end_date: "2024-02-28",
            description: "Replaced snowflake server configurations with Ansible playbooks across 200 GCE instances, eliminating configuration drift and cutting incident root cause time by 50%.",
            skills_used: "Ansible, GCP, Python, Bash"
          }
        ]
      },
      {
        company_name: "StartupLab SF",
        job_title: "Junior DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Francisco, CA",
        location_type: 1,
        start_date: "2021-03-01",
        end_date: "2023-04-30",
        description: "First DevOps hire at a seed-stage startup. Set up GCP project, CI/CD pipelines from scratch, and containerized all services with Docker.",
        projects: [
          {
            project_name: "GCP Infrastructure Bootstrap",
            project_status: 1,
            start_date: "2021-04-01",
            end_date: "2022-01-31",
            description: "Provisioned all GCP infrastructure with Terraform, set up GitLab CI pipelines for 6 microservices, and containerized the full stack — reducing deployment time from manual 2-hour process to 12-minute automated pipeline.",
            skills_used: "Terraform, GCP, Docker, GitLab CI, Bash"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "San Francisco State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2017-08-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Google Associate Cloud Engineer",
        issuing_org: "Google Cloud",
        issue_date: "2022-09-01",
        expiry_date: "2025-09-01",
        skills_covered: "GCP Core Services, GKE, GCS, IAM, Networking, Monitoring"
      }
    ]
  },

  # ── 39. Derek Moss — Staff DevOps / Infrastructure Engineer ──────────────
  {
    email: "derek.moss@example.com",
    full_name: "Derek Moss",
    first_name: "Derek",
    last_name: "Moss",
    phone: "+1-503-555-3901",
    city: "Portland",
    state: "OR",
    country: "US",
    postal_code: "97209",
    current_title: "Staff Infrastructure Engineer",
    about_me: "Staff infrastructure engineer with 9 years of experience operating cloud platforms at scale. Built and led platform teams at two unicorn startups. Deep expertise in multi-cloud architecture, cost optimization, and developer experience. Reduced cloud spend by $3.2M/year at my last company through right-sizing and reserved capacity planning.",
    linkedin_url: "https://linkedin.com/in/derekmoss-infra",
    github_url: "https://github.com/dmoss-infra",
    skills: [
      { name: "AWS",              category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 108, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",        category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 60,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Pulumi",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 96,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Go",               category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Datadog",          category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "ArgoCD",           category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "FinOps",           category: "Other",          proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",              category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 108, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Helix Commerce",
        job_title: "Staff Infrastructure Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Portland, OR",
        location_type: 2,
        start_date: "2022-04-01",
        end_date: nil,
        description: "Technical lead for the platform team of 8 engineers supporting 250 product engineers across 6 product lines. Setting infrastructure strategy, owning the AWS FinOps program, and driving the migration from Terraform to Pulumi for better type safety.",
        projects: [
          {
            project_name: "Cloud Cost Optimization Program",
            project_status: 1,
            start_date: "2022-06-01",
            end_date: "2023-05-31",
            description: "Implemented rightsizing automation, Savings Plans purchase strategy, and a real-time cost attribution dashboard — reducing annual AWS spend by $3.2M (34% reduction).",
            skills_used: "AWS, Python, Datadog, Terraform, FinOps"
          },
          {
            project_name: "Pulumi IaC Migration",
            project_status: 1,
            start_date: "2024-01-01",
            end_date: nil,
            description: "Migrating 400 Terraform resources to Pulumi Python across 5 AWS accounts to enable unit testing of infrastructure code and type-safe resource definitions.",
            skills_used: "Pulumi, Python, AWS, Terraform, Kubernetes"
          }
        ]
      },
      {
        company_name: "ScaleServe",
        job_title: "Senior DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Portland, OR",
        location_type: 3,
        start_date: "2018-02-01",
        end_date: "2022-03-31",
        description: "Senior DevOps engineer at a Series C startup, scaling infrastructure from 10M to 200M daily active users. Built the observability stack and Kubernetes platform from scratch.",
        projects: [
          {
            project_name: "Kubernetes Platform Build-out",
            project_status: 1,
            start_date: "2019-01-01",
            end_date: "2020-06-30",
            description: "Designed and rolled out EKS-based multi-cluster Kubernetes platform across 3 AWS regions, migrating 80 services and enabling per-service auto-scaling that reduced EC2 costs by $1.1M/year.",
            skills_used: "Kubernetes, AWS EKS, Terraform, ArgoCD, Helm"
          }
        ]
      },
      {
        company_name: "DevOps Consulting LLC",
        job_title: "DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Portland, OR",
        location_type: 1,
        start_date: "2015-09-01",
        end_date: "2018-01-31",
        description: "Consulted for SMBs on AWS migrations and CI/CD modernization.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "Oregon State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2011-09-01",
        end_date: "2015-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Solutions Architect - Professional",
        issuing_org: "Amazon Web Services",
        issue_date: "2021-05-01",
        expiry_date: "2024-05-01",
        skills_covered: "AWS Advanced Architecture, HA Design, Cost Optimization, Migration"
      },
      {
        certificate_name: "Certified Kubernetes Administrator (CKA)",
        issuing_org: "Cloud Native Computing Foundation",
        issue_date: "2020-11-01",
        expiry_date: "2023-11-01",
        skills_covered: "Kubernetes, Cluster Administration, Networking, Storage, Security"
      }
    ]
  },

  # ── 40. Nadia Osei — Junior AI / ML Engineer ──────────────────────────────
  {
    email: "nadia.osei@example.com",
    full_name: "Nadia Osei",
    first_name: "Nadia",
    last_name: "Osei",
    phone: "+1-470-555-4001",
    city: "Atlanta",
    state: "GA",
    country: "US",
    postal_code: "30301",
    current_title: "Junior Machine Learning Engineer",
    about_me: "Junior ML engineer with a strong academic background in statistics and 1 year of industry experience building and deploying classification models. Proficient in Python and scikit-learn. Actively learning PyTorch and MLOps practices to grow toward production ML systems.",
    linkedin_url: "https://linkedin.com/in/nadiaosei-ml",
    github_url: "https://github.com/nosei-ml",
    skills: [
      { name: "Python",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Primary",   year_last_used: 2026 },
      { name: "scikit-learn",  category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Pandas",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Primary",   year_last_used: 2026 },
      { name: "NumPy",         category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "PyTorch",       category: "AI & LLM Tools", proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 8,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "SQL",           category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "FastAPI",       category: "Backend",        proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 8,  skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",           category: "Source Control", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Pinnacle Analytics",
        job_title: "Junior Machine Learning Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Atlanta, GA",
        location_type: 3,
        start_date: "2025-07-01",
        end_date: nil,
        description: "Building and maintaining churn prediction and lead scoring models for a B2B marketing SaaS. Collaborating with the data science team on feature engineering and model evaluation.",
        projects: [
          {
            project_name: "Customer Churn Prediction Model",
            project_status: 1,
            start_date: "2025-08-01",
            end_date: nil,
            description: "Trained and deployed a gradient boosting churn classifier achieving 0.79 AUC, identifying at-risk accounts 30 days in advance and informing outreach campaigns.",
            skills_used: "Python, scikit-learn, Pandas, SQL, FastAPI"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Georgia Institute of Technology",
        degree_obtained: "Master of Science",
        field_of_study: "Analytics",
        start_date: "2023-08-01",
        end_date: "2025-05-31",
        still_studying: false,
        description: "Concentration in Machine Learning. Capstone: Predicting hospital no-show rates using ensemble methods on 3-year appointment data."
      },
      {
        school_name: "University of Ghana",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Statistics",
        start_date: "2018-09-01",
        end_date: "2022-07-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Google Professional Machine Learning Engineer",
        issuing_org: "Google Cloud",
        issue_date: "2025-03-01",
        expiry_date: "2027-03-01",
        skills_covered: "ML on GCP, Vertex AI, Feature Engineering, Model Training, Deployment"
      }
    ]
  },

  # ── 41. Hassan Al-Farsi — Senior AI Infrastructure Engineer ──────────────
  {
    email: "hassan.alfarsi@example.com",
    full_name: "Hassan Al-Farsi",
    first_name: "Hassan",
    last_name: "Al-Farsi",
    phone: "+1-206-555-4101",
    city: "Seattle",
    state: "WA",
    country: "US",
    postal_code: "98103",
    current_title: "Senior AI Infrastructure Engineer",
    about_me: "AI infrastructure engineer with 7 years of experience building large-scale GPU training clusters and high-throughput model serving systems. Specializes in distributed training with PyTorch, inference optimization with TensorRT, and cost-efficient GPU capacity management. Helped scale LLM training to 1,024-GPU jobs at my current organization.",
    linkedin_url: "https://linkedin.com/in/hassanalfarsi-aiinfra",
    github_url: "https://github.com/halfarsi-ai",
    skills: [
      { name: "PyTorch",          category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "CUDA",             category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "TensorRT",         category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",       category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Ray",              category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",              category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Triton Inference Server", category: "AI & LLM Tools", proficiency: "Advanced", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "C++",              category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2025 },
      { name: "Git",              category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 84, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Foundry AI Labs",
        job_title: "Senior AI Infrastructure Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 3,
        start_date: "2022-11-01",
        end_date: nil,
        description: "Building and operating the GPU compute platform used to train and serve large language models. Manages a fleet of 2,000+ NVIDIA H100 GPUs on AWS, owning distributed training orchestration, inference serving infrastructure, and GPU utilization efficiency.",
        projects: [
          {
            project_name: "1K-GPU Distributed Training Pipeline",
            project_status: 1,
            start_date: "2023-03-01",
            end_date: "2023-12-31",
            description: "Designed and stabilized a 1,024-GPU PyTorch FSDP training pipeline for a 70B-parameter LLM using AWS p4de instances, achieving 91% MFU and reducing training cost per token by 28%.",
            skills_used: "PyTorch, CUDA, Ray, AWS, Kubernetes, Python"
          },
          {
            project_name: "Low-latency Inference Serving Platform",
            project_status: 1,
            start_date: "2024-04-01",
            end_date: "2024-11-30",
            description: "Built a TensorRT + Triton-based inference serving system achieving p99 latency of 180ms for a 13B-parameter model at 2,000 QPS — 3.5x throughput improvement over the previous vLLM setup.",
            skills_used: "TensorRT, Triton Inference Server, CUDA, Python, Kubernetes"
          }
        ]
      },
      {
        company_name: "Vision AI Co",
        job_title: "ML Infrastructure Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Bellevue, WA",
        location_type: 3,
        start_date: "2019-07-01",
        end_date: "2022-10-31",
        description: "Built training and inference infrastructure for a computer vision product used in autonomous vehicle perception. Optimized model inference latency from 120ms to 18ms using TensorRT.",
        projects: [
          {
            project_name: "Edge Inference Optimization",
            project_status: 1,
            start_date: "2020-02-01",
            end_date: "2021-01-31",
            description: "Converted YOLOv5 object detection model to TensorRT FP16, achieving 6.7x inference speedup on NVIDIA Jetson AGX devices while maintaining 98.3% of original mAP.",
            skills_used: "TensorRT, CUDA, PyTorch, Python, C++"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Washington",
        degree_obtained: "Master of Science",
        field_of_study: "Electrical and Computer Engineering",
        start_date: "2017-09-01",
        end_date: "2019-06-30",
        still_studying: false,
        description: "Focus on high-performance computing and GPU architecture."
      },
      {
        school_name: "King Abdullah University of Science and Technology",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2013-09-01",
        end_date: "2017-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "NVIDIA Deep Learning Institute: Fundamentals of Deep Learning",
        issuing_org: "NVIDIA",
        issue_date: "2021-04-01",
        expiry_date: nil,
        skills_covered: "CUDA, PyTorch, GPU Computing, Model Optimization, Parallelism"
      }
    ]
  },

  # ── 42. Lena Hoffmann — Mid-level AI Engineer (NLP / RAG) ─────────────────
  {
    email: "lena.hoffmann@example.com",
    full_name: "Lena Hoffmann",
    first_name: "Lena",
    last_name: "Hoffmann",
    phone: "+1-617-555-4201",
    city: "Boston",
    state: "MA",
    country: "US",
    postal_code: "02115",
    current_title: "AI Engineer",
    about_me: "AI engineer with 3 years of experience building NLP pipelines and retrieval-augmented generation systems for enterprise search products. Strong Python background and hands-on experience fine-tuning open-source language models. Focused on making LLM outputs measurable and trustworthy through structured evaluation.",
    linkedin_url: "https://linkedin.com/in/lenahoffmann-ai",
    github_url: "https://github.com/lhoffmann-nlp",
    skills: [
      { name: "Python",          category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Hugging Face",    category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "LangChain",       category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Primary",   year_last_used: 2026 },
      { name: "OpenAI API",      category: "AI & LLM Tools", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 18, skill_type: "Secondary", year_last_used: 2026 },
      { name: "pgvector",        category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 12, skill_type: "Secondary", year_last_used: 2026 },
      { name: "FastAPI",         category: "Backend",        proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "PostgreSQL",      category: "Databases",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",          category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Lexis AI",
        job_title: "AI Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Boston, MA",
        location_type: 2,
        start_date: "2023-09-01",
        end_date: nil,
        description: "Building RAG-powered legal document search for a legaltech platform used by 300+ law firms. Owns the retrieval pipeline, embedding strategy, and LLM evaluation harness.",
        projects: [
          {
            project_name: "Hybrid Legal Document Search",
            project_status: 1,
            start_date: "2023-11-01",
            end_date: "2024-06-30",
            description: "Implemented hybrid BM25 + dense retrieval pipeline with cross-encoder re-ranking over 40M legal documents, improving answer relevance (NDCG@5) by 31% over keyword-only baseline.",
            skills_used: "Python, Hugging Face, pgvector, LangChain, FastAPI, PostgreSQL"
          }
        ]
      },
      {
        company_name: "TextMine Inc",
        job_title: "NLP Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Cambridge, MA",
        location_type: 1,
        start_date: "2021-06-01",
        end_date: "2023-08-31",
        description: "Developed NLP models for document classification, named entity recognition, and sentiment analysis for a market intelligence platform.",
        projects: [
          {
            project_name: "Multi-label Document Classifier",
            project_status: 1,
            start_date: "2022-01-01",
            end_date: "2022-09-30",
            description: "Fine-tuned DeBERTa-v3 for 48-label financial document classification, achieving 0.87 macro-F1 and replacing a 3-year-old rules engine used in production.",
            skills_used: "Python, Hugging Face Transformers, PyTorch, FastAPI, Docker"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "Northeastern University",
        degree_obtained: "Master of Science",
        field_of_study: "Computer Science (NLP Concentration)",
        start_date: "2019-09-01",
        end_date: "2021-05-31",
        still_studying: false,
        description: nil
      },
      {
        school_name: "Ludwig Maximilian University of Munich",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computational Linguistics",
        start_date: "2015-10-01",
        end_date: "2019-07-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "DeepLearning.AI Natural Language Processing Specialization",
        issuing_org: "DeepLearning.AI",
        issue_date: "2022-08-01",
        expiry_date: nil,
        skills_covered: "NLP, Attention Mechanisms, Transformers, BERT, Sequence Models"
      }
    ]
  },

  # ── 43. Troy Nguyen — Senior DevOps Engineer (Azure / GitLab CI) ──────────
  {
    email: "troy.nguyen@example.com",
    full_name: "Troy Nguyen",
    first_name: "Troy",
    last_name: "Nguyen",
    phone: "+1-425-555-4301",
    city: "Redmond",
    state: "WA",
    country: "US",
    postal_code: "98052",
    current_title: "Senior DevOps Engineer",
    about_me: "Senior DevOps engineer with 6 years of experience on the Microsoft Azure ecosystem. Expert in Azure DevOps pipelines, AKS, and Azure infrastructure-as-code with Bicep and Terraform. Worked with enterprise teams up to 400 engineers, standardizing deployment practices and reducing release cycle time by 70%.",
    linkedin_url: "https://linkedin.com/in/troynguyen-azure",
    github_url: "https://github.com/tnguyen-devops",
    skills: [
      { name: "Azure",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Azure DevOps",      category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubernetes",        category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",         category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Bicep",             category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Docker",            category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 60, skill_type: "Secondary", year_last_used: 2026 },
      { name: "PowerShell",        category: "Languages",      proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",            category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Helm",              category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Git",               category: "Source Control", proficiency: "Advanced",     years_of_exp: "5 - 10 years",      years_of_exp_in_months: 72, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Enterprise Cloud Corp",
        job_title: "Senior DevOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "Redmond, WA",
        location_type: 3,
        start_date: "2021-10-01",
        end_date: nil,
        description: "Leading DevOps practice for an enterprise SaaS product with 400 engineers on Azure. Owns the Azure DevOps pipelines, AKS cluster management, and IaC standards across 15 product teams.",
        projects: [
          {
            project_name: "AKS Multi-environment Standardization",
            project_status: 1,
            start_date: "2022-02-01",
            end_date: "2022-11-30",
            description: "Standardized AKS deployment patterns across dev, staging, and prod environments using Helm charts and Azure DevOps pipeline templates, reducing per-team CI setup time from 2 weeks to 1 day.",
            skills_used: "Azure, AKS, Helm, Terraform, Azure DevOps"
          },
          {
            project_name: "Blue/Green Deployment Rollout",
            project_status: 1,
            start_date: "2023-06-01",
            end_date: "2024-01-31",
            description: "Implemented blue/green deployment strategy across 30 services, reducing deployment-related incidents by 80% and enabling instant rollback for all customer-facing services.",
            skills_used: "Azure DevOps, Kubernetes, Helm, Bicep, PowerShell"
          }
        ]
      },
      {
        company_name: "Contoso Digital",
        job_title: "DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "Seattle, WA",
        location_type: 1,
        start_date: "2018-08-01",
        end_date: "2021-09-30",
        description: "Built and maintained CI/CD pipelines and Azure infrastructure for a digital transformation consultancy serving Fortune 1000 clients.",
        projects: [
          {
            project_name: "Legacy CI Migration to Azure DevOps",
            project_status: 1,
            start_date: "2019-03-01",
            end_date: "2020-01-31",
            description: "Migrated 8 clients from on-premise Jenkins to Azure DevOps with YAML pipelines and self-hosted agents, cutting average build times by 55%.",
            skills_used: "Azure DevOps, Docker, Terraform, PowerShell, Bicep"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "University of Washington",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Engineering",
        start_date: "2014-09-01",
        end_date: "2018-06-30",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "Microsoft Certified: DevOps Engineer Expert",
        issuing_org: "Microsoft",
        issue_date: "2021-05-01",
        expiry_date: nil,
        skills_covered: "Azure DevOps, Pipelines, Repos, Artifacts, Infrastructure as Code"
      },
      {
        certificate_name: "Microsoft Certified: Azure Administrator Associate",
        issuing_org: "Microsoft",
        issue_date: "2020-02-01",
        expiry_date: nil,
        skills_covered: "Azure VMs, Networking, Storage, Identity, Monitoring"
      }
    ]
  },

  # ── 44. Simone Adeyemi — Principal AI / ML Architect ─────────────────────
  {
    email: "simone.adeyemi@example.com",
    full_name: "Simone Adeyemi",
    first_name: "Simone",
    last_name: "Adeyemi",
    phone: "+1-212-555-4401",
    city: "New York",
    state: "NY",
    country: "US",
    postal_code: "10013",
    current_title: "Principal AI/ML Architect",
    about_me: "Principal AI/ML architect with 11 years of experience across academia and industry. Led AI strategy and platform architecture at two publicly traded companies. Deep expertise in production ML systems, responsible AI practices, and executive stakeholder alignment. Designed the end-to-end ML platform now serving 50+ data scientists at my current organization. Speaker at NeurIPS, ICML industry tracks.",
    linkedin_url: "https://linkedin.com/in/simoneadeyemi-ai",
    github_url: "https://github.com/sadeyemi-ai",
    skills: [
      { name: "Python",           category: "Languages",      proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 132, skill_type: "Primary",   year_last_used: 2026 },
      { name: "PyTorch",          category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "5 - 10 years",       years_of_exp_in_months: 72,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "MLflow",           category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years",  years_of_exp_in_months: 48,  skill_type: "Primary",   year_last_used: 2026 },
      { name: "Kubeflow",         category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years",  years_of_exp_in_months: 42,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "AWS",              category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "5 - 10 years",       years_of_exp_in_months: 84,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "Spark",            category: "Backend",        proficiency: "Advanced",     years_of_exp: "5 - 10 years",       years_of_exp_in_months: 72,  skill_type: "Secondary", year_last_used: 2025 },
      { name: "LangChain",        category: "AI & LLM Tools", proficiency: "Advanced",     years_of_exp: "Less than 5 years",  years_of_exp_in_months: 24,  skill_type: "Secondary", year_last_used: 2026 },
      { name: "System Design",    category: "Other",          proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 132, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Scala",            category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years",  years_of_exp_in_months: 36,  skill_type: "Tertiary",  year_last_used: 2024 },
      { name: "Git",              category: "Source Control", proficiency: "Advanced",     years_of_exp: "More than 10 years", years_of_exp_in_months: 132, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Meridian Financial Group",
        job_title: "Principal AI/ML Architect",
        work_status: 1,
        employment_type: 1,
        location: "New York, NY",
        location_type: 3,
        start_date: "2021-03-01",
        end_date: nil,
        description: "Setting AI/ML platform strategy and architecture for a $12B asset management firm. Leading a team of 6 senior ML engineers, overseeing the design and delivery of the enterprise ML platform, and advising C-suite on responsible AI governance.",
        projects: [
          {
            project_name: "Enterprise ML Platform",
            project_status: 1,
            start_date: "2021-06-01",
            end_date: "2023-01-31",
            description: "Architected and delivered the company's first unified ML platform — Kubeflow on EKS with MLflow registry and Feast feature store — enabling 50+ data scientists to go from experiment to production 5x faster.",
            skills_used: "Kubeflow, MLflow, Feast, AWS EKS, Terraform, Python"
          },
          {
            project_name: "LLM-powered Risk Summarization",
            project_status: 1,
            start_date: "2023-07-01",
            end_date: "2024-04-30",
            description: "Designed a RAG-based system for automated generation of investment risk summaries from 10-K filings, validated by compliance and now used by 200+ analysts daily.",
            skills_used: "LangChain, OpenAI API, pgvector, Python, AWS"
          }
        ]
      },
      {
        company_name: "DataSphere Analytics",
        job_title: "Senior ML Engineer",
        work_status: 0,
        employment_type: 1,
        location: "New York, NY",
        location_type: 1,
        start_date: "2016-04-01",
        end_date: "2021-02-28",
        description: "Senior ML engineer building large-scale recommendation and anomaly detection systems for media and e-commerce clients. Co-led a team of 5 engineers.",
        projects: [
          {
            project_name: "Real-time Recommendation Engine",
            project_status: 1,
            start_date: "2017-09-01",
            end_date: "2019-03-31",
            description: "Built a two-tower neural retrieval model serving personalized content recommendations at 50K QPS with p99 latency under 30ms, increasing engagement by 22%.",
            skills_used: "Python, PyTorch, Spark, AWS, Redis"
          }
        ]
      },
      {
        company_name: "Columbia University - Data Science Institute",
        job_title: "Research Scientist",
        work_status: 0,
        employment_type: 1,
        location: "New York, NY",
        location_type: 1,
        start_date: "2013-09-01",
        end_date: "2016-03-31",
        description: "Postdoctoral researcher publishing on probabilistic graphical models and causal inference. 8 peer-reviewed publications with 800+ citations.",
        projects: []
      }
    ],
    educations: [
      {
        school_name: "Columbia University",
        degree_obtained: "Doctor of Philosophy",
        field_of_study: "Computer Science (Machine Learning)",
        start_date: "2008-09-01",
        end_date: "2013-06-30",
        still_studying: false,
        description: "Dissertation: Scalable variational inference for latent variable models"
      },
      {
        school_name: "University of Lagos",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Mathematics and Computer Science",
        start_date: "2004-09-01",
        end_date: "2008-07-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Machine Learning - Specialty",
        issuing_org: "Amazon Web Services",
        issue_date: "2022-01-01",
        expiry_date: "2025-01-01",
        skills_covered: "SageMaker, ML Pipelines, Feature Engineering, Model Deployment, Monitoring"
      }
    ]
  },

  # ── 45. Riku Tanaka — Mid-level DevOps Engineer (Jenkins / On-prem + Cloud) ─
  {
    email: "riku.tanaka@example.com",
    full_name: "Riku Tanaka",
    first_name: "Riku",
    last_name: "Tanaka",
    phone: "+1-408-555-4501",
    city: "San Jose",
    state: "CA",
    country: "US",
    postal_code: "95128",
    current_title: "DevOps Engineer",
    about_me: "DevOps engineer with 4 years of experience bridging on-premise and cloud infrastructure. Expert in Jenkins pipeline development and gradual cloud migrations to AWS. Comfortable managing hybrid environments and translating legacy release processes into modern CI/CD workflows. Currently pursuing Kubernetes certification.",
    linkedin_url: "https://linkedin.com/in/rikutanaka-devops",
    github_url: "https://github.com/rtanaka-devops",
    skills: [
      { name: "Jenkins",         category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Primary",   year_last_used: 2026 },
      { name: "AWS",             category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Docker",          category: "Cloud & DevOps", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 42, skill_type: "Primary",   year_last_used: 2026 },
      { name: "Terraform",       category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 24, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Ansible",         category: "Cloud & DevOps", proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 36, skill_type: "Secondary", year_last_used: 2025 },
      { name: "Bash",            category: "Languages",      proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Kubernetes",      category: "Cloud & DevOps", proficiency: "Beginner",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 10, skill_type: "Secondary", year_last_used: 2026 },
      { name: "Python",          category: "Languages",      proficiency: "Intermediate", years_of_exp: "Less than 5 years", years_of_exp_in_months: 30, skill_type: "Tertiary",  year_last_used: 2026 },
      { name: "Git",             category: "Source Control", proficiency: "Advanced",     years_of_exp: "Less than 5 years", years_of_exp_in_months: 48, skill_type: "Tertiary",  year_last_used: 2026 }
    ],
    work_experiences: [
      {
        company_name: "Nexgen Manufacturing",
        job_title: "DevOps Engineer",
        work_status: 1,
        employment_type: 1,
        location: "San Jose, CA",
        location_type: 1,
        start_date: "2022-07-01",
        end_date: nil,
        description: "Managing hybrid CI/CD infrastructure for a manufacturing software company migrating from on-premise to AWS. Owns Jenkins shared library, Docker image registry, and Terraform-based AWS provisioning.",
        projects: [
          {
            project_name: "On-prem to AWS Lift-and-shift",
            project_status: 1,
            start_date: "2023-01-01",
            end_date: "2024-03-31",
            description: "Migrated 14 applications from bare-metal servers to AWS EC2 and ECS using Terraform, reducing infrastructure provisioning time from 3 weeks to 2 hours and cutting hosting costs by 40%.",
            skills_used: "Terraform, AWS, Docker, Jenkins, Bash"
          }
        ]
      },
      {
        company_name: "WebSoft Agency",
        job_title: "Junior DevOps Engineer",
        work_status: 0,
        employment_type: 1,
        location: "San Jose, CA",
        location_type: 1,
        start_date: "2020-04-01",
        end_date: "2022-06-30",
        description: "Set up and maintained Jenkins pipelines for 10+ client projects. Managed Linux servers and automated deployments using Ansible and Bash.",
        projects: [
          {
            project_name: "Jenkins Shared Library",
            project_status: 1,
            start_date: "2021-02-01",
            end_date: "2021-09-30",
            description: "Built a reusable Jenkins shared library covering build, test, and deploy stages — reducing per-project pipeline setup from 2 days to 2 hours across 10 client codebases.",
            skills_used: "Jenkins, Docker, Bash, Ansible, Git"
          }
        ]
      }
    ],
    educations: [
      {
        school_name: "San Jose State University",
        degree_obtained: "Bachelor of Science",
        field_of_study: "Computer Science",
        start_date: "2016-08-01",
        end_date: "2020-05-31",
        still_studying: false,
        description: nil
      }
    ],
    certifications: [
      {
        certificate_name: "AWS Certified Developer - Associate",
        issuing_org: "Amazon Web Services",
        issue_date: "2023-03-01",
        expiry_date: "2026-03-01",
        skills_covered: "AWS Lambda, DynamoDB, S3, SQS, SNS, CloudFormation, API Gateway"
      }
    ]
  }
].freeze

# ── Seeding logic ──────────────────────────────────────────────────────────────

puts "Seeding #{SEED_CANDIDATES.length} candidate profiles..."
puts "(Embeddings are skipped — run `rails embeddings:generate_all` next)\n\n"

SEED_CANDIDATES.each do |data|
  if User.exists?(email: data[:email])
    puts "  Skipping #{data[:full_name]} (already exists)"
    next
  end

  puts "  Creating #{data[:full_name]}..."

  # Creating the user triggers after_create :create_candidate_profile
  user = User.create!(
    email: data[:email],
    password: "password123",
    password_confirmation: "password123",
    full_name: data[:full_name],
    role: "candidate"
  )

  candidate = user.candidate
  candidate.update!(
    first_name:    data[:first_name],
    last_name:     data[:last_name],
    email:         data[:email],
    phone:         data[:phone],
    city:          data[:city],
    state:         data[:state],
    country:       data[:country],
    postal_code:   data[:postal_code],
    current_title: data[:current_title],
    about_me:      data[:about_me],
    linkedin_url:  data[:linkedin_url],
    github_url:    data[:github_url]
  )

  data[:skills].each { |s| candidate.candidate_skills.create!(s) }

  data[:work_experiences].each do |exp_data|
    projects = exp_data[:projects] || []
    work_exp = candidate.work_experiences.create!(exp_data.except(:projects))
    projects.each { |p| work_exp.work_projects.create!(p) }
  end

  data[:educations].each { |e| candidate.educations.create!(e) }

  data[:certifications].each { |c| candidate.certifications.create!(c) }

  skill_count = data[:skills].length
  exp_count   = data[:work_experiences].length
  puts "    -> #{skill_count} skills, #{exp_count} work experiences\n"
end

puts "\nDone! #{Candidate.count} candidates in database."
puts "Next step: rails embeddings:generate_all"
