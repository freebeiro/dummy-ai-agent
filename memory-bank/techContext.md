# Technical Context: DummyAIAgent

**Core Technologies:**
*   **Backend Framework:** Ruby 3.2.x, Rails 7.1
    *   Database: SQLite (default for development)
    *   Key Gems:
        *   `httparty`: For making HTTP requests to the DummyJSON API.
        *   `ruby-openai`: For interacting with the OpenAI API.
        *   `bootstrap`: (via `cssbundling-rails` or `dartsass-rails`) For basic UI styling.
*   **Frontend Framework:** Hotwire (Turbo & Stimulus)
    *   Default Rails 7 frontend. Chosen for rapid UI development with minimal custom JavaScript.
    *   Turbo Streams will be used for real-time chat message updates.
*   **External APIs:**
    *   **DummyJSON API:** (`https://dummyjson.com/docs/products`) Source for product catalog data.
    *   **OpenAI API:** To power the AI agent's responses and recommendations.
        *   API Key (for PoC use): `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` (Note: Not for production).

**Development Setup Notes:**
*   Standard Rails installation (`rails new ...`).
*   Ensure Ruby 3.2.x and Rails 7.1 are installed.
*   `bundle install` to get gems.
*   `rails db:migrate` for database schema.
*   `rails server` to run the application.

**Key Technical Decisions (driven by 2-hour PoC constraint):**
*   **Simplicity over Robustness:** Focus on getting core features working. Error handling will be basic.
*   **Rails Conventions:** Adhere closely to Rails conventions to speed up development.
*   **Hotwire for UI:** Leverage Hotwire to minimize custom JavaScript and achieve responsive UI updates quickly.
*   **Synchronous Operations:** API calls will likely be synchronous within controller actions for simplicity in this PoC. Background jobs are out of scope.
*   **Minimal Styling:** Rely on Bootstrap for basic, presentable UI. No extensive custom CSS.
*   **No Automated Tests:** As per requirements. Manual testing of the chat flow is key.
*   **Single Conversation Context:** For simplicity, the chat might operate within a single, ongoing conversation context per user session. "Start new chat" might just clear the display or start a new `Conversation` record without complex user session management.
