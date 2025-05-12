# Rails Conventions (DummyAIAgent PoC)

*   **Convention over Configuration (CoC):** Prioritize Rails defaults to speed up development.
*   **Naming:**
    *   Models: Singular, CamelCase (e.g., `ProductOrder`).
    *   Controllers: Plural, CamelCase, append `Controller` (e.g., `ChatsController`).
    *   Database Tables: Plural, snake_case (e.g., `product_orders`).
    *   Variables & Methods: snake_case (e.g., `current_user`, `create_message`).
*   **Routing:** Use `resources` for RESTful routes where appropriate (e.g., `resources :chats`). For unique actions, define them clearly.
*   **Models:** Keep models focused on data and associations. Business logic directly related to a model can reside there.
*   **Controllers:** Keep controllers lean. Their primary role is to handle requests, interact with models, and select views/responses.
*   **Views:** Standard ERB templates. Use partials for reusable components.
*   **Simplicity:** Given the 2-hour limit, avoid overly complex patterns or abstractions unless absolutely necessary.
