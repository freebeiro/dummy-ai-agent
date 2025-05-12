# Hotwire Patterns (DummyAIAgent PoC)

*   **Turbo Drive:** Enabled by default; rely on it for page navigation.
*   **Turbo Frames:** Use `<turbo-frame>` for independent sections of the page that can be updated without a full page reload (e.g., the chat message input form, a product details view).
*   **Turbo Streams:**
    *   Primary mechanism for real-time updates, especially for new chat messages.
    *   Broadcast from controllers/models to append/prepend/replace content in specific `<turbo-frame>` tags or DOM IDs.
    *   Example: New messages should be appended to the chat history container.
*   **Stimulus Controllers:**
    *   Use sparingly. Only if a specific client-side interaction is needed that Turbo cannot handle easily (e.g., clearing an input field after form submission via Turbo Stream, toggling a UI element state).
    *   Keep controllers small and focused.
*   **No Custom JavaScript (Beyond Stimulus):** Strive to achieve all dynamic behavior through Turbo and Stimulus to align with Hotwire's philosophy and save time.
*   **Broadcasting:** Use Action Cable (or its async adapter for simplicity in PoC) to broadcast Turbo Stream updates for chat messages.
