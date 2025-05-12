# New Project Bootstrapping Workflow Guide (v4.1 - Enhanced Classification & Purpose)

This guide outlines the structured process for initiating a new project using a capable AI assistant with access to core operational rules (e.g., `global_rules.md` via user settings) and file system tools. The user acts as the orchestrator, guiding the AI through these steps and managing the local file system.

## Phase 1: Initiation & Intelligent Context Gathering

1.  **User Trigger Prompt:** Start the interaction with the AI using a prompt describing the project. Place a copy of this guide in the project root and reference it, e.g.,
    `AI, initiate the project setup for 'ai_rule_generator' following @[NEW_PROJECT_BOOTSTRAP.md]. Goal: Build a tool with a modern UI to assist in generating project-specific rule files.`
    *(Note: Ensure the @[] reference points correctly to the file within the *current* project workspace).*

2.  **AI Mandatory First Action: Project Classification, Parse, Confirm & Query:** Following the instructions from the referenced guide, the AI *must*:

    a. **Context Analysis:** If project-related files are already shared, analyze them for additional context before proceeding.
       
    b. **Project Classification & Purpose:** Identify both the project's scope category and its purpose:
    
       **Scope Categories:**
       - **Full Project:** Complete application with multiple features and components (e.g., a complete e-commerce platform)
       - **Feature Implementation:** Single feature within an existing project (e.g., adding a recommendation system to an e-commerce site)
       - **Step Implementation:** Sub-component of a feature (e.g., implementing the algorithm for a recommendation system)
       - **Script/Utility:** Small, focused tool or script (e.g., a data migration script)
       - **Research/Proof of Concept:** Time-boxed exploration (e.g., a 2-hour interview project, a weekend hackathon)
       
       **Development Intent:**
       - **MVP (Minimum Viable Product):** Initial version with core functionality only, expecting future iterations
       - **Full-Featured Solution:** Comprehensive implementation covering all requirements
       - **Technical Demonstration:** Focused on showcasing specific technologies or approaches
       - **Time-Boxed Deliverable:** Must be completed within strict time constraints (e.g., 2-hour interview)
       - **Learning Exercise:** Primary goal is knowledge acquisition rather than production use
       
    c. **Structured Understanding Summary:** Present understanding in a clear, point-by-point format:
       ```
       Please confirm each point (Yes/No):
       - Project Name: [Name]? (Yes/No)
       - Project Scope: [Type from scope categories]? (Yes/No)
       - Development Intent: [Type from development intent]? (Yes/No)
       - Primary Goal: [Goal]? (Yes/No)
       - Problem Solved: [Problem]? (Yes/No)
       - Target Users: [Users]? (Yes/No)
       - Core Features: [List key features]? (Yes/No)
       - Initial Tech Stack: [Technologies]? (Yes/No)
       - Key Constraints: [Constraints]? (Yes/No)
       ```
       
    d. **Tech Stack Checklist:** Address all relevant technology categories:
       - Backend Framework (with version)
       - Frontend/UI Framework (with version)
       - Database and Extensions
       - API Integration Methods
       - Real-time Features (if applicable)
       - AI/ML Components (if applicable)
       
    e. **Source of Inferred Features:** When listing features, cite the source of inference (e.g., "Based on the project description document, I understand the core features include...")
    
    f. **Missing Context Questions:** Ask ONLY essential missing questions, clearly labeled
    
    g. **Minimum Viable Features:** Request confirmation of the minimum viable features (MVF)
    
    h. **Timeline Assessment:** For all projects, explicitly ask about timeline constraints and how they affect scope prioritization. For time-boxed projects (e.g., interviews, hackathons), emphasize the need to prioritize features that can be completed within the time constraint.
    
    i. **Optional Components:** Query about Testing, Git, Deployment strategies
    
    j. **Research Signaling:** Explicitly state intention to research all mentioned technologies to verify versions and best practices after user confirmation

3.  **User Provides Context & Confirmations:** Answer the AI's specific questions and confirm its understanding.

4.  **AI Researches & Finalizes Tech Stack:** BEFORE proceeding, the AI *must* use its research tools (web search, Context7, etc.) to:
    *   Verify latest stable versions of proposed technologies.
    *   Check for known compatibility issues or significant drawbacks.
    *   Confirm alignment with current best practices for the project type.
    *   Identify any emerging alternatives that might better suit the project requirements.
    *   For time-constrained projects, prioritize technologies with rapid setup and minimal configuration.
    
    The AI presents findings and confirms the final tech stack choices with the user.
    *(No file generation in this phase yet)*

## Phase 2: Task-Specific Guideline Generation

5.  **AI Identifies & Proposes Rule Categories:** Based on the confirmed context and finalized tech stack, the AI identifies *relevant* rule categories and proposes them (e.g., "For the `ai_rule_generator` with React/FastAPI, I suggest rules for `API_DESIGN`, `REACT_STYLE`, `TESTING_STRATEGY`, `SECURITY`. OK?").

    **Rule Category Adaptation:** The AI should adapt the depth and breadth of rule categories based on the project's scope and development intent:
    - For time-boxed projects, focus on minimal, essential rules
    - For MVPs, focus on rules that enable rapid iteration
    - For full-featured solutions, provide comprehensive rule categories
    - For learning exercises, include educational comments within rules

6.  **User Confirms/Adjusts Rule Categories.**

7.  **AI Researches & Generates Draft Rule Files:** For each confirmed category, the AI *must* first **research** current best practices, official documentation, popular tooling (linters, formatters), and conventions specific to the chosen tech stack and project type. Based on this research, it generates draft content (e.g., `rules/REACT_STYLE.md`) reflecting up-to-date standards. 
    
    **Testing Guidelines:** When generating testing guidelines (if testing was requested), the AI must ensure the draft covers standard levels (Unit, Integration, System/E2E) and include recommendations for testing infrastructure appropriate to the project type and classification.

8.  **AI Presents Draft Rules & Prompts User to Save:** "Based on research into current best practices, here is the draft content for each rule file. Please review, adjust if needed, and save these to a `rules/` directory. Let me know when done."

9.  **User Saves Files & Confirms:** Manually create `rules/` directory and save the files locally. Confirm to the AI.

## Phase 3: Initial Planning

10. **AI Researches & Generates Project Plan:** Based on the confirmed context and MVP features, the AI generates the initial high-level `PROJECT_PLAN.md` content. For tasks involving specific technical implementations, the AI should perform a quick **research check** to ensure the proposed approach aligns with current best practices before outlining the task.

    **Plan Adaptation:** The plan structure should reflect both the project scope classification and development intent:
    - **Full Project:** Comprehensive phased approach with milestones
    - **Feature Implementation:** Focused tasks with integration points
    - **Step Implementation:** Detailed implementation steps with dependencies
    - **Script/Utility:** Straightforward development and testing steps
    - **Research/POC:** Time-boxed exploration phases with evaluation points
    
    **Timeline-Driven Planning:** For time-constrained projects, the plan must:
    - Explicitly state the time constraint at the beginning
    - Prioritize tasks that deliver core functionality first
    - Identify "nice-to-have" features that can be omitted if time runs short
    - Include specific checkpoints to assess progress against the timeline
    - Propose a simplified "fallback approach" if the primary approach proves too time-consuming

11. **AI Presents Plan & Prompts User to Save:** "Here is the initial `PROJECT_PLAN.md`, incorporating current best practices for key technical steps. Please review and save this to your project root. Let me know when done."

12. **User Saves Plan & Confirms:** Save the file locally. Confirm to the AI.

## Phase 4: Memory Bank Initialization

13. **AI Generates Memory Bank Content:** Now that context, rules, and plan (informed by research) are defined, the AI generates the content for all initial Memory Bank files:
    *   `memory-bank/projectbrief.md`
    *   `memory-bank/productContext.md`
    *   `memory-bank/techContext.md` (Reflecting finalized, researched tech stack)
    *   `memory-bank/systemPatterns.md`
    *   `memory-bank/progress.md`
    *   `memory-bank/activeContext.md`

    **Memory Content Adaptation:** The content and detail level should be adapted based on project scope and intent:
    - For time-boxed projects, focus on essential information needed for rapid implementation
    - For MVPs, emphasize core functionality and extension points
    - For learning exercises, include educational notes and explanations

14. **AI Presents Memory Content & Prompts User to Save:** "I have generated the initial content for all memory bank files... Please save these into a `memory-bank/` directory... Let me know when done."

15. **User Saves Files & Confirms:** Manually create `memory-bank/` directory and save all files locally. Confirm to the AI.

## Phase 5: Final Handoff

16. **AI Acknowledges & Starts:** The AI confirms completion... "Setup complete... Starting task 1 from `PROJECT_PLAN.md`: [Task Description]..."
    *(User Verification Recommended...)*

**Setup is now complete. Development proceeds following the Act/Plan modes, guided by the generated `PROJECT_PLAN.md`, project-specific `rules/`, contextual `memory-bank/`, and the assumed active global rules.**
