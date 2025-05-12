# System Patterns: DummyAIAgent (PoC)

**Overall Architecture:** Standard Ruby on Rails Monolith.

*   **MVC (Model-View-Controller):** Core Rails pattern.
    *   **Models:** `Conversation`, `Message`, `Order`. Responsible for data persistence and basic associations.
    *   **Views:** ERB templates rendered by Rails, with dynamic updates handled by Hotwire (Turbo Frames/Streams). Partials for chat messages and forms.
    *   **Controllers:** `ChatsController` (primary), potentially `OrdersController`. Handle user requests, interact with models and services, manage responses.

*   **Service Objects (Simple):**
    *   `DummyJsonService`: Encapsulates logic for fetching product data from the DummyJSON API.
    *   `OpenAiService`: Encapsulates logic for interacting with the OpenAI API (sending prompts, receiving responses).
    *   These services will be called directly from controllers.

*   **Hotwire for Frontend Interactivity:**
    *   **Turbo Streams:** For real-time updates of the chat interface (appending new messages). Messages broadcast from models or controllers.
    *   **Turbo Frames:** Used for the message input form to allow seamless submission and updates.
    *   **StimulusJS:** Minimal use, only if essential for small client-side interactions not easily covered by Turbo.

*   **API Integration Pattern:**
    *   Direct synchronous calls from service objects to external APIs (DummyJSON, OpenAI) using `HTTParty` and `ruby-openai`.
    *   Basic error handling within services (e.g., logging, returning nil or default data).

*   **Data Flow (Chat Message):**
    1.  User submits message via form (Turbo Frame).
    2.  `ChatsController#create` receives params.
    3.  User's `Message` is created and saved.
    4.  User's `Message` is broadcast via Turbo Stream to append to the chat view.
    5.  User's message is sent to `OpenAiService`.
    6.  `OpenAiService` calls OpenAI API.
    7.  AI's response is received.
    8.  AI's `Message` is created and saved.
    9.  AI's `Message` is broadcast via Turbo Stream to append to the chat view.

*   **Data Flow (Order Creation - Simplified):**
    1.  AI (guided by prompts) determines user is ready to order and has collected necessary info.
    2.  AI's response indicates this (e.g., specific keywords or structured data).
    3.  `ChatsController` parses AI's response.
    4.  If order criteria met, `ChatsController` (or `OrdersController`) creates an `Order` record with the collected details.
    5.  A confirmation message is sent to the user via chat (as another AI or system message).

*   **State Management:**
    *   Conversation state primarily managed by database records (`Conversation`, `Message`).
    *   Current conversation loaded in `ChatsController#show`.
    *   No complex client-side state management beyond what Hotwire provides.

**Simplifications for PoC:**
*   No background jobs for API calls.
*   Minimal error handling complexity.
*   Direct use of API key in service (acknowledged as not for production).
*   Single `ChatsController` might handle most logic to reduce file switching and complexity within 2 hours.
