#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="tech-interview-prep"
echo "Creating project in ./${ROOT_DIR}"

# remove any existing folder/zip (comment out if you prefer to keep)
rm -rf "${ROOT_DIR}" "${ROOT_DIR}.zip"

mkdir -p "${ROOT_DIR}/public"
mkdir -p "${ROOT_DIR}/src/pages"
mkdir -p "${ROOT_DIR}/src/data"

# package.json
cat > "${ROOT_DIR}/package.json" <<'EOF'
{
  "name": "tech-interview-prep",
  "version": "1.0.0",
  "private": true,
  "homepage": "https://sekharanaru4321.github.io/tech-interview-prep",
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.14.1"
  },
  "devDependencies": {
    "gh-pages": "^5.0.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "predeploy": "npm run build",
    "deploy": "gh-pages -d build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
EOF

# public/index.html
cat > "${ROOT_DIR}/public/index.html" <<'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Software Techies Interview Prep</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>
EOF

# src/index.js
cat > "${ROOT_DIR}/src/index.js" <<'EOF'
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import './styles.css';

const root = createRoot(document.getElementById('root'));
root.render(<App />);
EOF

# src/App.js (includes the user-provided snippet exactly)
cat > "${ROOT_DIR}/src/App.js" <<'EOF'
import React from "react";
import { BrowserRouter as Router, Route, Routes, Link } from "react-router-dom";
import Home from "./pages/Home";
import Topics from "./pages/Topics";
import InterviewQuestions from "./pages/InterviewQuestions";
import Resources from "./pages/Resources";
import About from "./pages/About";

function App() {
  return (
    <Router>
      <nav className="topnav">
        <div className="nav-inner">
          <Link to="/" className="brand">Tech Interview Prep</Link>
          <div className="nav-links">
            <Link to="/">Home</Link>
            <Link to="/topics">Topics</Link>
            <Link to="/questions">Interview Questions</Link>
            <Link to="/resources">Resources</Link>
            <Link to="/about">About</Link>
          </div>
        </div>
      </nav>
      <main className="container">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/topics" element={<Topics />} />
          <Route path="/questions" element={<InterviewQuestions />} />
          <Route path="/resources" element={<Resources />} />
          <Route path="/about" element={<About />} />
        </Routes>
      </main>
      <footer className="footer">
        <div>© {new Date().getFullYear()} Software Techies Interview Prep</div>
      </footer>
    </Router>
  );
}
export default App;
EOF

# src/styles.css
cat > "${ROOT_DIR}/src/styles.css" <<'EOF'
:root {
  --bg: #f7f9fc;
  --card: #ffffff;
  --accent: #2b6cb0;
  --muted: #6b7280;
}
body {
  margin: 0;
  font-family: Inter, Roboto, Arial, sans-serif;
  background: var(--bg);
  color: #111827;
}
.topnav {
  background: white;
  border-bottom: 1px solid #e5e7eb;
  position: sticky;
  top: 0;
  z-index: 50;
}
.nav-inner {
  max-width: 960px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  padding: 14px;
  align-items: center;
}
.brand {
  font-weight: 700;
  color: var(--accent);
  text-decoration: none;
}
.nav-links a {
  margin-left: 14px;
  color: #111827;
  text-decoration: none;
}
.container {
  max-width: 960px;
  margin: 24px auto;
  padding: 0 16px;
}
.card {
  background: var(--card);
  border-radius: 8px;
  padding: 18px;
  box-shadow: 0 1px 2px rgba(15,23,42,0.04);
  margin-bottom: 16px;
}
h1,h2 {
  margin: 0 0 12px 0;
}
ul { padding-left: 18px; }
.question {
  padding: 12px;
  border-bottom: 1px dashed #e6e9ef;
}
.question strong { color: var(--accent); }
.footer {
  max-width: 960px;
  margin: 24px auto;
  padding: 16px;
  color: var(--muted);
}
.search {
  padding: 10px;
  width: 100%;
  max-width: 480px;
  margin-bottom: 12px;
  border-radius: 6px;
  border: 1px solid #e5e7eb;
}
.topic-btn {
  display: inline-block;
  background: #eef2ff;
  color: #3730a3;
  padding: 6px 10px;
  border-radius: 999px;
  margin: 6px 6px 0 0;
  cursor: pointer;
  border: none;
}
EOF

# src/pages/Home.js
cat > "${ROOT_DIR}/src/pages/Home.js" <<'EOF'
import React from "react";

export default function Home() {
  return (
    <div className="card">
      <h1>Welcome to Software Techies Interview Prep</h1>
      <p>Your one-stop platform for mastering the latest technologies and acing your tech interviews.</p>
      <ul>
        <li>Explore trending tech topics</li>
        <li>Practice interview questions with concise answers</li>
        <li>Find curated resources and guides</li>
      </ul>
    </div>
  );
}
EOF

# src/pages/Topics.js
cat > "${ROOT_DIR}/src/pages/Topics.js" <<'EOF'
import React from "react";
import questions from "../data/questions.json";

export default function Topics() {
  const topics = Object.keys(questions);
  return (
    <div className="card">
      <h2>Latest Technologies</h2>
      <div>
        {topics.map((t) => (
          <button key={t} className="topic-btn" onClick={() => {
            const el = document.getElementById(`topic-${t}`);
            if (el) el.scrollIntoView({ behavior: 'smooth' });
          }}>{t}</button>
        ))}
      </div>
      <div style={{ marginTop: 16 }}>
        {topics.map((t) => (
          <section id={`topic-${t}`} key={t} style={{ marginBottom: 12 }}>
            <h3>{t}</h3>
            <ul>
              {questions[t].map((q, i) => <li key={i}>{q.question}</li>)}
            </ul>
          </section>
        ))}
      </div>
    </div>
  );
}
EOF

# src/pages/InterviewQuestions.js
cat > "${ROOT_DIR}/src/pages/InterviewQuestions.js" <<'EOF'
import React, { useState } from "react";
import questions from "../data/questions.json";

export default function InterviewQuestions() {
  const topics = Object.keys(questions);
  const [active, setActive] = useState(topics[0]);
  const [query, setQuery] = useState("");

  const list = questions[active].filter(q =>
    (q.question + " " + (q.answer || "")).toLowerCase().includes(query.toLowerCase())
  );

  return (
    <div className="card">
      <h2>Interview Questions</h2>
      <div style={{ display: 'flex', gap: 12, alignItems: 'center', marginBottom: 12 }}>
        <select value={active} onChange={(e) => setActive(e.target.value)}>
          {topics.map(t => <option key={t} value={t}>{t}</option>)}
        </select>
        <input className="search" placeholder="Search questions or answers..." value={query} onChange={(e)=>setQuery(e.target.value)} />
      </div>

      <div>
        {list.map((q, i) => (
          <div key={i} className="question">
            <div><strong>{active}:</strong> {q.question}</div>
            {q.answer && <div style={{ marginTop: 8 }}>{q.answer}</div>}
            {q.difficulty && <div style={{ marginTop: 8, color: '#6b7280' }}>Difficulty: {q.difficulty}</div>}
            {q.tags && <div style={{ marginTop: 8, color: '#6b7280' }}>Tags: {q.tags.join(", ")}</div>}
          </div>
        ))}
        {list.length === 0 && <div>No results found.</div>}
      </div>
    </div>
  );
}
EOF

# src/pages/Resources.js
cat > "${ROOT_DIR}/src/pages/Resources.js" <<'EOF'
import React from "react";

const resources = [
  { name: "React Docs", url: "https://react.dev/" },
  { name: "Python Tutorials", url: "https://docs.python.org/3/tutorial/" },
  { name: "AWS Training", url: "https://aws.amazon.com/training/" },
  { name: "Kubernetes Docs", url: "https://kubernetes.io/docs/" },
  { name: "System Design Primer", url: "https://github.com/donnemartin/system-design-primer" }
];

export default function Resources() {
  return (
    <div className="card">
      <h2>Resources</h2>
      <ul>
        {resources.map((r, i) => (
          <li key={i}><a href={r.url} target="_blank" rel="noreferrer">{r.name}</a></li>
        ))}
      </ul>
    </div>
  );
}
EOF

# src/pages/About.js
cat > "${ROOT_DIR}/src/pages/About.js" <<'EOF'
import React from "react";

export default function About() {
  return (
    <div className="card">
      <h2>About</h2>
      <p>
        Software Techies Interview Prep is a community-focused static site to help software professionals prepare for interviews across modern technologies.
      </p>
      <p>
        Contribution: add more questions by editing src/data/questions.json and opening a PR in your repository.
      </p>
    </div>
  );
}
EOF

# src/data/questions.json
cat > "${ROOT_DIR}/src/data/questions.json" <<'EOF'
{
  "React": [
    { "question": "What are React Hooks?", "answer": "Hooks are functions that let you use state and lifecycle features in function components.", "difficulty": "intermediate", "tags": ["hooks","state"] },
    { "question": "Explain the Virtual DOM.", "answer": "Virtual DOM is an in-memory representation of the real DOM used to compute minimal updates for performance.", "difficulty": "intermediate", "tags": ["virtual-dom","performance"] },
    { "question": "What is reconciliation in React?", "answer": "Reconciliation is React's process for diffing the virtual DOM trees and applying the minimal set of changes to the real DOM.", "difficulty": "advanced", "tags": ["reconciliation"] },
    { "question": "When would you use useMemo and useCallback?", "answer": "useMemo and useCallback cache values/functions to avoid unnecessary recalculations or re-renders.", "difficulty": "intermediate" },
    { "question": "Explain controlled vs uncontrolled components.", "answer": "Controlled components get input values from state; uncontrolled components use refs to access DOM values.", "difficulty": "beginner" },
    { "question": "What is context and when to use it?", "answer": "Context provides a way to pass data through the component tree without props drilling; use for global-like data.", "difficulty": "intermediate" },
    { "question": "How do you optimize a large list in React?", "answer": "Use virtualization (e.g., react-window), keys, and avoid anonymous inline functions to reduce re-renders.", "difficulty": "advanced" },
    { "question": "What are error boundaries?", "answer": "Error boundaries are components that catch JavaScript errors in child components and render a fallback UI.", "difficulty": "intermediate" }
  ],
  "Python": [
    { "question": "Explain list comprehensions.", "answer": "List comprehensions provide a concise way to create lists from iterables with optional filtering.", "difficulty": "beginner" },
    { "question": "What is GIL (Global Interpreter Lock)?", "answer": "GIL is a mutex in CPython that prevents multiple native threads from executing Python bytecodes simultaneously.", "difficulty": "advanced" },
    { "question": "Difference between list and tuple.", "answer": "Lists are mutable, tuples are immutable; tuples can be used as dictionary keys.", "difficulty": "beginner" },
    { "question": "Explain generators and yield.", "answer": "Generators yield values lazily and maintain state between yields, useful for streaming data.", "difficulty": "intermediate" },
    { "question": "How does exception handling work?", "answer": "Use try/except/finally blocks; except can catch specific exceptions and finally always executes.", "difficulty": "beginner" },
    { "question": "What are decorators?", "answer": "Decorators are functions that modify the behavior of other functions or classes, typically using the @ syntax.", "difficulty": "intermediate" },
    { "question": "Explain duck typing.", "answer": "Duck typing relies on object behavior rather than type; if it walks like a duck, treat it as a duck.", "difficulty": "intermediate" },
    { "question": "What are type hints and why use them?", "answer": "Type hints provide optional static type information to improve readability and tooling checks.", "difficulty": "beginner" }
  ],
  "AI & Machine Learning": [
    { "question": "What is supervised learning?", "answer": "Supervised learning trains models on labeled data to predict outputs for new inputs.", "difficulty": "beginner" },
    { "question": "Explain overfitting and ways to prevent it.", "answer": "Overfitting occurs when a model fits training data too closely; prevent with regularization, dropout, cross-validation, or more data.", "difficulty": "intermediate" },
    { "question": "What is gradient descent?", "answer": "Gradient descent is an optimization algorithm that updates parameters by following the negative gradient of the loss.", "difficulty": "intermediate" },
    { "question": "Difference between classification and regression.", "answer": "Classification predicts categories, regression predicts continuous values.", "difficulty": "beginner" },
    { "question": "What are evaluation metrics for classification?", "answer": "Accuracy, precision, recall, F1-score, ROC-AUC are common metrics.", "difficulty": "intermediate" },
    { "question": "What is transfer learning?", "answer": "Transfer learning reuses a pre-trained model on a new related task to save time and data.", "difficulty": "intermediate" },
    { "question": "Explain bias-variance tradeoff.", "answer": "Bias is error from wrong assumptions; variance is error from sensitivity to data; balance is required.", "difficulty": "intermediate" },
    { "question": "What is an embedding?", "answer": "An embedding maps discrete items (like words) into continuous vector space capturing semantics.", "difficulty": "intermediate" }
  ],
  "Cloud Computing": [
    { "question": "What is IaaS, PaaS, SaaS?", "answer": "IaaS provides virtualized infrastructure, PaaS adds platform tools, SaaS delivers software via the cloud.", "difficulty": "beginner" },
    { "question": "What is serverless computing?", "answer": "Serverless runs code in managed containers triggered by events; scaling and infra management are abstracted away.", "difficulty": "intermediate" },
    { "question": "Explain eventual consistency.", "answer": "Eventual consistency means updates propagate asynchronously and replicas converge over time.", "difficulty": "intermediate" },
    { "question": "What is autoscaling?", "answer": "Autoscaling increases or decreases compute resources automatically based on load.", "difficulty": "beginner" },
    { "question": "How do you secure cloud resources?", "answer": "Use IAM, least privilege, VPCs, encryption at rest/in transit, logging and monitoring.", "difficulty": "intermediate" },
    { "question": "What are regions and availability zones?", "answer": "Regions are geographic areas; availability zones are isolated data centers within regions for fault tolerance.", "difficulty": "beginner" },
    { "question": "Explain infrastructure as code (IaC).", "answer": "IaC manages infrastructure via code (e.g., Terraform) enabling reproducibility and versioning.", "difficulty": "intermediate" },
    { "question": "What is multi-cloud strategy?", "answer": "Using multiple cloud vendors to reduce vendor lock-in or improve resilience and optimization.", "difficulty": "advanced" }
  ],
  "DevOps": [
    { "question": "What is CI/CD?", "answer": "CI is Continuous Integration; CD is Continuous Delivery/Deployment for frequent automated releases.", "difficulty": "beginner" },
    { "question": "Explain the role of monitoring and observability.", "answer": "Monitoring tracks metrics and alerts; observability helps understand system internals via logs, traces, and metrics.", "difficulty": "intermediate" },
    { "question": "What is Infrastructure as Code?", "answer": "IaC automates infrastructure provisioning through declarative code, improving repeatability.", "difficulty": "intermediate" },
    { "question": "What is blue/green deployment?", "answer": "Blue/green runs two production environments and switches traffic to a new one to reduce downtime during deploys.", "difficulty": "intermediate" },
    { "question": "Explain canary releases.", "answer": "Canary releases deploy new changes to a small subset of users before wider rollout to mitigate risk.", "difficulty": "intermediate" },
    { "question": "How do you manage secrets in CI/CD?", "answer": "Use secret managers, environment variables with restricted access, and avoid committing secrets to VCS.", "difficulty": "intermediate" },
    { "question": "What are runbooks?", "answer": "Runbooks are documented procedures for incident response and common operational tasks.", "difficulty": "beginner" },
    { "question": "How to design CI pipelines for monorepos?", "answer": "Use affected/changed-file detection, incremental builds, and job parallelization to scale pipelines.", "difficulty": "advanced" }
  ],
  "Docker & Kubernetes": [
    { "question": "What is a Docker image vs container?", "answer": "Image is a packaged filesystem and metadata; container is a running instance of an image.", "difficulty": "beginner" },
    { "question": "Explain the purpose of Kubernetes.", "answer": "Kubernetes orchestrates containerized workloads with scheduling, scaling, and self-healing.", "difficulty": "beginner" },
    { "question": "What is a Pod in Kubernetes?", "answer": "Pod is the smallest deployable unit; it can contain one or more co-located containers.", "difficulty": "beginner" },
    { "question": "How do Services work in K8s?", "answer": "Services provide stable network access (ClusterIP/NodePort/LoadBalancer) to Pods.", "difficulty": "intermediate" },
    { "question": "What is a ReplicaSet and Deployment?", "answer": "ReplicaSet ensures a specified number of pod replicas; Deployment manages ReplicaSets and rollouts.", "difficulty": "intermediate" },
    { "question": "How to handle persistent storage in Kubernetes?", "answer": "Use PersistentVolumes and PersistentVolumeClaims backed by storage classes for durable storage.", "difficulty": "intermediate" },
    { "question": "What is a DaemonSet?", "answer": "DaemonSet ensures a copy of a Pod runs on selected nodes (e.g., for logging or monitoring agents).", "difficulty": "advanced" },
    { "question": "Best practices for Dockerfile?", "answer": "Keep images small, use multi-stage builds, pin versions, and minimize layers for caching efficiency.", "difficulty": "intermediate" }
  ],
  "Java": [
    { "question": "Explain JVM, JRE, and JDK.", "answer": "JVM runs Java bytecode, JRE provides runtime environment, JDK includes tools to build Java apps.", "difficulty": "beginner" },
    { "question": "What is garbage collection?", "answer": "GC automatically reclaims memory from objects no longer reachable; different algorithms tune for throughput or latency.", "difficulty": "intermediate" },
    { "question": "Difference between equals() and ==.", "answer": "== compares references; equals() compares values (when overridden appropriately).", "difficulty": "beginner" },
    { "question": "What are checked vs unchecked exceptions?", "answer": "Checked exceptions must be declared/handled; unchecked (RuntimeException) do not require declaration.", "difficulty": "intermediate" },
    { "question": "Explain Java generics.", "answer": "Generics enable type-safe collections and APIs with compile-time type checks and type erasure at runtime.", "difficulty": "intermediate" },
    { "question": "What is immutability and why use it?", "answer": "Immutable objects cannot change state after creation, improving thread-safety and predictability.", "difficulty": "intermediate" },
    { "question": "How does synchronization work in Java?", "answer": "synchronized keyword controls access to critical sections by a single thread per monitor lock.", "difficulty": "intermediate" },
    { "question": "What are Java streams?", "answer": "Streams provide a functional-style API for processing collections with operations like map, filter and reduce.", "difficulty": "intermediate" }
  ],
  "TypeScript": [
    { "question": "Why use TypeScript over JavaScript?", "answer": "TypeScript adds static typing, improved tooling, and earlier error detection for maintainable codebases.", "difficulty": "beginner" },
    { "question": "What are types vs interfaces?", "answer": "Both define shapes; interfaces are extendable and better for OO, types are more flexible for unions and aliases.", "difficulty": "intermediate" },
    { "question": "Explain generics in TypeScript.", "answer": "Generics allow writing reusable components that work with a variety of types while preserving type safety.", "difficulty": "intermediate" },
    { "question": "What is declaration merging?", "answer": "Declaration merging combines multiple declarations of the same name (e.g., interfaces) into a single definition.", "difficulty": "advanced" },
    { "question": "How to gradually migrate a JS project to TS?", "answer": "Enable allowJs, add tsconfig, convert files incrementally, and use `any` cautiously.", "difficulty": "intermediate" },
    { "question": "Explain type inference.", "answer": "TypeScript infers types when explicit annotations are omitted, reducing verbosity while keeping safety.", "difficulty": "beginner" },
    { "question": "What are utility types?", "answer": "Utility types (Partial, Pick, Omit, Required) transform existing types to create new ones.", "difficulty": "intermediate" },
    { "question": "What is discriminated union?", "answer": "A union of types with a common discriminant property allowing safe type narrowing.", "difficulty": "advanced" }
  ],
  "Cybersecurity": [
    { "question": "What is the principle of least privilege?", "answer": "Grant only the minimum permissions necessary for a user or process to function.", "difficulty": "beginner" },
    { "question": "Explain OWASP Top 10 briefly.", "answer": "A list of the top web app security risks such as injection, broken auth, XSS, and misconfigurations.", "difficulty": "intermediate" },
    { "question": "What is XSS and how to prevent it?", "answer": "Cross-site scripting injects scripts into web pages; prevent with output encoding and input validation.", "difficulty": "intermediate" },
    { "question": "What is CSRF and mitigation strategies?", "answer": "CSRF tricks users into performing actions; mitigate with anti-CSRF tokens and same-site cookies.", "difficulty": "intermediate" },
    { "question": "How to secure APIs?", "answer": "Use authentication (OAuth/JWT), TLS, rate limiting, input validation, and proper error handling.", "difficulty": "intermediate" },
    { "question": "Explain public key infrastructure (PKI).", "answer": "PKI uses public/private key pairs and certificates to enable secure key exchange and authentication.", "difficulty": "advanced" },
    { "question": "What is threat modeling?", "answer": "Threat modeling identifies assets, threats, and mitigations to design secure systems.", "difficulty": "advanced" },
    { "question": "How to store passwords securely?", "answer": "Use salted hashing algorithms like bcrypt/argon2, not plain hashing or reversible encryption.", "difficulty": "intermediate" }
  ],
  "SQL & Databases": [
    { "question": "What is normalization?", "answer": "Normalization organizes data to reduce redundancy; common normal forms include 1NF, 2NF, 3NF.", "difficulty": "intermediate" },
    { "question": "Difference between SQL and NoSQL.", "answer": "SQL uses relational schemas and ACID; NoSQL favors flexible schemas and eventual consistency for scale.", "difficulty": "beginner" },
    { "question": "What is an index and when to use it?", "answer": "Indexes speed up reads by enabling fast lookups but slow writes and consume space.", "difficulty": "intermediate" },
    { "question": "Explain transactions and ACID.", "answer": "Transactions are atomic operations; ACID ensures Atomicity, Consistency, Isolation, Durability.", "difficulty": "intermediate" },
    { "question": "What is sharding?", "answer": "Sharding splits data across multiple machines to scale horizontally.", "difficulty": "advanced" },
    { "question": "How to choose between relational and document DB?", "answer": "Choose relational for structured, relational data and strong consistency; document DBs for flexible schemas and rapid iteration.", "difficulty": "intermediate" },
    { "question": "Describe optimistic vs pessimistic locking.", "answer": "Optimistic assumes low conflict and checks on commit; pessimistic locks data to avoid conflicts.", "difficulty": "advanced" },
    { "question": "What is denormalization and why use it?", "answer": "Denormalization duplicates data to optimize read performance at the cost of write complexity.", "difficulty": "intermediate" }
  ],
  "System Design": [
    { "question": "How to design a URL shortener like bit.ly?", "answer": "Use a service to generate unique short IDs, map to long URLs in a database, use caching and analytics pipeline.", "difficulty": "advanced" },
    { "question": "What is CAP theorem?", "answer": "A distributed system can provide only two of Consistency, Availability, and Partition tolerance at the same time.", "difficulty": "advanced" },
    { "question": "How to design a high-throughput message queue?", "answer": "Partition topics, use replication, avoid single points of failure, and design backpressure strategies.", "difficulty": "advanced" },
    { "question": "What is load balancing and types?", "answer": "Distributes traffic across servers; types include round-robin, least connections, IP-hash, and L7 routing.", "difficulty": "intermediate" },
    { "question": "How to design for eventual consistency?", "answer": "Use idempotent operations, conflict resolution, and background reconciliation.", "difficulty": "advanced" },
    { "question": "What are the building blocks of large-scale systems?", "answer": "Client, API layer, services, data stores, cache, messaging, monitoring, and CDNs.", "difficulty": "intermediate" },
    { "question": "How do you handle spike traffic?", "answer": "Autoscale, use queuing, rate limiting, throttling, and CDNs to absorb spikes.", "difficulty": "advanced" },
    { "question": "Explain write-ahead logging.", "answer": "WAL writes changes to a durable log before applying to the DB to ensure durability and recovery.", "difficulty": "advanced" }
  ],
  "Algorithms & Data Structures": [
    { "question": "Explain time complexity Big-O for binary search.", "answer": "Binary search runs in O(log n) time.", "difficulty": "beginner" },
    { "question": "What is the difference between array and linked list?", "answer": "Arrays provide O(1) index access; linked lists allow O(1) insert/delete at known position but O(n) access.", "difficulty": "beginner" },
    { "question": "Describe quicksort average and worst-case complexity.", "answer": "Average O(n log n), worst-case O(n^2) without randomization or good pivoting.", "difficulty": "intermediate" },
    { "question": "What is dynamic programming?", "answer": "DP solves problems by caching intermediate results to avoid recomputation.", "difficulty": "intermediate" },
    { "question": "Explain BFS vs DFS.", "answer": "BFS explores level by level and finds shortest path on unweighted graphs; DFS dives deep and uses less memory in some cases.", "difficulty": "intermediate" },
    { "question": "When to use a hash table vs tree map?", "answer": "Hash tables give average O(1) lookup; tree maps provide ordered keys and O(log n) operations.", "difficulty": "intermediate" },
    { "question": "What is a heap and when to use it?", "answer": "A heap is a priority queue supporting fast access to min or max, useful for scheduling and top-k queries.", "difficulty": "intermediate" },
    { "question": "Explain two-pointer technique.", "answer": "Two pointers move from ends or together to solve problems like pair sums, sliding windows, and linked list cycles.", "difficulty": "intermediate" }
  ]
}
EOF

# README.md
cat > "${ROOT_DIR}/README.md" <<'EOF'
# Tech Interview Prep (Software Techies)

A static React site with curated interview questions across modern technologies.

How to run locally:
1. npm install
2. npm start

Deploy to GitHub Pages:
1. Ensure package.json "homepage" is set to `https://<your-username>.github.io/tech-interview-prep`
2. npm run deploy

Project structure:
- public/
- src/
  - pages/
  - data/questions.json

Edit questions:
- Update `src/data/questions.json` to add more questions, answers, difficulty, and tags.
EOF

# Create the zip
echo "Creating zip: ${ROOT_DIR}.zip"
cd "${ROOT_DIR}/.."
zip -r "${ROOT_DIR}.zip" "${ROOT_DIR}" > /dev/null

echo "Done. Generated ${ROOT_DIR} and ${ROOT_DIR}.zip in $(pwd)"
echo
echo "Next steps:"
echo "1) Unzip and inspect files: unzip ${ROOT_DIR}.zip"
echo "2) Install deps and run: cd ${ROOT_DIR} && npm install && npm start"
echo "3) To deploy to GitHub Pages: set 'homepage' in package.json to your URL and run: npm run deploy"
EOF