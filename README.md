# DummyAIAgent - Proof of Concept

This is a Ruby on Rails application built as a 2-hour Proof of Concept (PoC) for a technical interview. It simulates a simple AI-powered e-commerce chat agent.

## Features
*   Chat interface for interacting with an AI assistant.
*   Integration with DummyJSON API to fetch a product list (for AI context).
*   Integration with OpenAI API (gpt-3.5-turbo) for AI responses.
*   AI-guided collection of order information (name, address, email, phone, product, quantity).
*   Simulated order creation (Order record saved to database).
*   Collapsible sidebar for listing and navigating conversations.
*   "New Chat" functionality.

## Tech Stack
*   **Backend:** Ruby 3.2.2, Rails 7.1.x (as per `.ruby-version` and initial plan, though `techContext.md` might have mentioned 7.1, the actual setup used the latest 7.1 compatible version at the time of creation or what `rails new` provided).
*   **Frontend:** Hotwire (Turbo & Stimulus), Bootstrap for styling.
*   **Database:** SQLite3
*   **Key Gems:**
    *   `httparty` (for DummyJSON API)
    *   `ruby-openai` (for OpenAI API)
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
    *   The OpenAI API key is currently hardcoded in `app/services/open_ai_service.rb` for this PoC. For a real application, this should be managed via Rails credentials or environment variables.
    ```ruby
    # app/services/open_ai_service.rb
    OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY', 'YOUR_API_KEY_HERE'))
    ```
    Replace `'YOUR_API_KEY_HERE'` with your actual key if the hardcoded one is not working or if you prefer to use an ENV variable.

### Running the application
1.  **Start the development server:**
    ```bash
    ./bin/dev
    ```
2.  Open your browser and navigate to `http://localhost:3000`.

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

## Potential Future Improvements
*   More robust error handling.
*   Proper parsing of structured data from AI for order creation.
*   User authentication.
*   More sophisticated state management for conversations if scaling.
*   Deployment scripts/configuration.
*   Automated tests.
