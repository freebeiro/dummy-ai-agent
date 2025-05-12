# Timebox Strategy (DummyAIAgent PoC - 2 Hours)

*   **Overall Goal:** Deliver a functional prototype demonstrating core features within 2 hours. Perfection is not the goal; a working demo is.
*   **Prioritization (Strict):**
    1.  **Basic Rails App Setup:** (Ruby 3.2.x, Rails 7.1) - ~10 mins
    2.  **Core Chat Interface (Hotwire):**
        *   Models: `Conversation`, `Message`.
        *   Controller: `ChatsController` (show, create message).
        *   Basic view to display messages and a form to send messages.
        *   Turbo Stream broadcasting for new messages.
        *   ~40 mins
    3.  **DummyJSON Product Display:**
        *   Service to fetch products (e.g., `HTTParty`).
        *   Simple display of product list or ability to query/show one product.
        *   Hardcoding a small product list is a fallback if API integration is slow.
        *   ~20 mins
    4.  **OpenAI Agent Integration (Basic):**
        *   Service to call OpenAI API (`ruby-openai`).
        *   Send user message to OpenAI, display AI response in chat.
        *   Initial prompt to guide AI for e-commerce context.
        *   ~25 mins
    5.  **Order Information Collection & Creation (Simplified):**
        *   AI guides user to provide order details (name, address, etc.).
        *   Model: `Order`.
        *   Controller action to create an order (no actual payment/external calls).
        *   AI triggers this action (simulated function call by parsing AI response).
        *   ~20 mins
    6.  **Refinements & README:** (Buffer)
        *   "Start new chat" (clear current conversation).
        *   "Revisit conversation history" (if easily doable by just showing all messages in current `Conversation`).
        *   Final Git commit, push, README notes.
        *   ~5 mins

*   **Time Checks:** Briefly assess progress every 30 minutes. Adjust scope aggressively if falling behind.
*   **Simplification:** If a feature proves too complex for the timeframe, simplify it or make a note to cut it. Examples:
    *   Conversation history might just be the current session's messages.
    *   "Start new chat" might just clear the screen and reset local state, not necessarily create a new `Conversation` record immediately.
    *   Product search might be omitted in favor of displaying a small, fixed list.
*   **Focus on Flow:** Prioritize demonstrating the end-to-end flow: user chats -> AI recommends -> user provides info -> order is (simulated) created.
*   **Communication:** If a significant deviation from the plan is needed due to time, note it for the README.
