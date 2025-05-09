s is what i need to # DummyAIAgent - Proof of Concept

This is a Ruby on Rails application built as a 2-hour Proof of Concept (PoC) for a technical interview. It simulates a simple AI-powered e-commerce chat agent.

## Features
*   Chat interface for interacting with an AI assistant.
*   Integration with DummyJSON API to fetch a product list (for AI context).
*   Integration with OpenAI API (gpt-3.5-turbo) for AI responses (intended, see Challenges section).
*   AI-guided collection of order information (name, address, email, phone, product, quantity).
*   Simulated order creation (Order record saved to database).
*   Collapsible sidebar for listing and navigating conversations.
*   "New Chat" functionality.

## Tech Stack
*   **Backend:** Ruby 3.2.2, Rails 7.2.2.1 (actual version used).
*   **Frontend:** Hotwire (Turbo & Stimulus), Bootstrap for styling.
*   **Database:** SQLite3
*   **Key Gems:**
    *   `httparty` (for DummyJSON API)
    *   `ruby-openai` (for OpenAI API)
    *   `dotenv-rails` (for managing environment variables like API keys)
    *   `cssbundling-rails` & `sassc-rails` (implicitly, for Bootstrap SCSS)

## Setup and Running the Application

### Prerequisites
*   Ruby 3.2.2 (can be managed with `asdf` using the included `.ruby-version` file)
*   Node.js (for JavaScript asset bundling, version specified in `.node-version`, e.g., 20.11.0)
*   Yarn (package manager for JavaScript)
*   Bundler (Ruby gem manager)

### Installation
1.  **Clone the repository (once pushed to GitHub):**
    ```bash
    # git clone [repository_url]
    # cd DummyAIAgent
    ```
    (For now, you are already in the `DummyAIAgent` project directory locally.)

2.  **Install Ruby version (if using `asdf`):**
    ```bash
    asdf install
    ```

3.  **Install dependencies:**
    ```bash
    bundle install
    yarn install
    ```

4.  **Setup database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

5.  **API Keys:**
    *   Create a `.env` file in the `DummyAIAgent` root directory.
    *   Add your OpenAI API key to this file:
        ```env
        OPENAI_API_KEY=YOUR_OPENAI_API_KEY
        ```
    *   The application is configured to load this key using the `dotenv-rails` gem.

### Running the application
1.  **Start the development server:**
    ```bash
    ./bin/dev
    ```
    (If you encounter issues with `foreman`, ensure it's in your Gemfile's development group: `gem "foreman", group: :development` and run `bundle install`.)
2.  Open your browser and navigate to `http://localhost:3000`.

## Project Journey & Challenges

### Achievements
*   Successfully set up a Rails 7 application with Hotwire.
*   Implemented core chat functionality including message creation, display, and real-time updates using Turbo Streams.
*   Integrated DummyJSON API to provide product context to the AI.
*   Designed and implemented a multi-conversation interface with a collapsible sidebar.
*   Implemented logic for AI-guided order information collection and simulated order creation.
*   Managed API keys using `.env` file and `dotenv-rails` gem, removing hardcoded keys from source code.

### API Key & AI Integration Challenges
*   **OpenAI API Key Issue:** During development, the initial OpenAI API key provided became invalid (returned 401 errors). This was confirmed via cURL tests. The standard solution is to obtain a new, valid key from the OpenAI dashboard and update the `.env` file.
*   **Attempt to Use Anthropic:** As a quick alternative to the OpenAI key issue, an attempt was made to integrate the Anthropic (Claude) API. This involved:
    *   Creating a new feature branch (`feature/anthropic-integration`).
    *   Adding the `ruby-anthropic` gem (after an initial mix-up with the older `anthropic` gem name).
    *   Creating an `AnthropicService`.
    *   Modifying the controller to use this service.
    *   However, persistent `LoadError` issues for the `ruby-anthropic` gem (even after server restarts, `bundle exec`, and explicitly adding `app/services` to autoload paths) prevented successful integration within the PoC timeframe. These changes were stashed and the project reverted to the OpenAI setup, awaiting a valid key.
*   **GitHub Push Protection:** When attempting to push the repository, GitHub's Push Protection correctly identified the (now removed from current code, but present in historical commits) OpenAI API key. This is a valuable security feature. The standard way to handle this for a PoC where the key is known and has been revoked/removed from active code is to use the "allow secret" link provided by GitHub in the error message. For production, a full Git history rewrite would be recommended if a secret was accidentally committed. We typically avoid this by using `.env` files or Rails credentials from the start, which was done after the initial hardcoding was identified.

## Approach & Notes
*   **Time Constraint:** Developed under a strict 2-hour time limit. Focus was on core functionality.
*   **Rails Conventions:** Adhered to Rails conventions where possible to speed up development.
*   **Hotwire:** Leveraged for dynamic UI updates with minimal custom JavaScript.
*   **Error Handling:** Basic error handling implemented for API calls.
*   **Order Parsing:** Simplified parsing of AI response for order details. A production system would use a more robust method (e.g., AI providing structured JSON).
*   **Styling:** Basic styling with Bootstrap. The sidebar and chat interface were styled to be more modern based on feedback.
*   **No Automated Tests:** As per PoC requirements. Manual testing was performed for the core flow.

## Deviations from Initial Plan (`PROJECT_PLAN.md`)
*   The product display section on the main chat page was removed based on user feedback during development to simplify the UI. Products are still fetched and used as context for the AI.
*   A collapsible sidebar for chat history was implemented as a refinement.
*   The primary AI integration switched focus from OpenAI to an attempted Anthropic integration due to API key issues, then reverted to OpenAI structure awaiting a valid key.

## Potential Future Improvements (If Time Permitted)
*   **UI Enhancements:**
    *   More polished visual design for chat bubbles, sidebar, and overall layout.
    *   Visual cues for message status (sending, sent, error).
*   **Interactive Product Catalog:** Instead of just context for the AI, display products with images and buttons (e.g., "Ask about this product", "Add to order inquiry").
*   **Robust Error Handling:** More user-friendly error messages and retry mechanisms.
*   **Advanced Order Parsing:** Use structured data (JSON) from AI for reliable order detail extraction.
*   User authentication.
*   More sophisticated state management for conversations if scaling.
*   Deployment scripts/configuration.
*   Automated tests.
