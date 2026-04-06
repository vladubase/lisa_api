# Contributing Guidelines

## Quality Gate & Governance
LISA API is the central nervous system of the warehouse. It orchestrates the movement of multiple AMRs and AGVs. Therefore, performance, concurrency, and high availability are our top priorities.

### 1. Git Flow
We employ a task-based branching strategy. Direct commits to the `main` branch are strictly prohibited.

**Branching Conventions:**
* `feat/name` — New functionality (e.g., new API endpoints, logic changes).
* `fix/name` — Bug fixes.
* `refactor/name` — Code restructuring without altering the underlying logic.
* `docs/name` — Documentation updates.

**Commit Messages:**
Adhere strictly to the [Conventional Commits](https://www.conventionalcommits.org/) specification:
* `feat: add VDA 5050 order parsing logic`
* `fix: resolve race condition in MQTT callback`
* `docs: update Swagger UI descriptions`

### 2. Pull Request (PR) Process
* Ensure that the code passes formatting (`black`) and linting (`flake8`) locally.
* The PR must include a comprehensive description of the introduced changes.
* New API endpoints must be accompanied by relevant Pydantic models and unit tests (`pytest`).
* The PR requires a review and approval from at least one other developer (Code Review).
* Continuous Integration (GitHub Actions) checks must pass (green state).

### 3. Architecture & Standards
LISA is designed as a scalable, asynchronous microservice.

**1. Asynchronous I/O (Concurrency)**
Since LISA handles hundreds of concurrent connections from robots (MQTT) and the WMS (HTTP), blocking operations are forbidden in the main thread.
* **Rule:** Always use `async`/`await` for network requests, database queries, and file I/O operations.
* **Framework:** Leverage FastAPI's built-in asynchronous capabilities.

**2. Data Validation & Typing**
We rely heavily on Python's type hinting system to prevent runtime errors.
* **Rule:** All function arguments and return values must have type hints.
* **Rule:** All incoming API requests and outgoing responses must be validated using `pydantic` models.

**3. VDA 5050 Compliance**
When modifying the MQTT communication logic with the AMRs, ensure strict adherence to the VDA 5050 protocol schema.
* Do not introduce custom, non-standard fields in the JSON payloads sent to the robots unless explicitly defined in the project's extensions.

### 4. Contribution Workflow

**Step 1. Fetch the latest project version**
```bash
git checkout main
git pull origin main
```

**Step 2. Create a new branch** Use descriptive names adhering to the aforementioned prefixes.
```bash
git checkout -b feat/my-new-feature
```

**Step 3. Stage and commit changes**
```bash
git add src/ tests/
git commit -m "feat: implement basic trajectory validation"
```

**Step 4. Push to the remote repository**
```bash
git push -u origin feat/my-new-feature
```

Navigate to GitHub and click **"Compare & pull request"**. A senior developer will review your PR. Upon successful CI testing and approval, your changes will be merged into the `main` branch.