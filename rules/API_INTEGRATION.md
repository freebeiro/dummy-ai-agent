# API Integration (DummyAIAgent PoC)

*   **DummyJSON API (Products):**
    *   Use the `HTTParty` gem for requests.
    *   Create a simple service object or helper method (e.g., `DummyJsonService.fetch_products`, `DummyJsonService.search_products`).
    *   Handle basic errors (timeouts, 404s) gracefully, perhaps by returning an empty array or a default message.
    *   For the 2-hour PoC, fetching all products initially and filtering/displaying a subset might be faster than implementing full search, unless search is trivial.
*   **OpenAI API (AI Agent):**
    *   Use the `ruby-openai` gem.
    *   Create a simple service object or helper method (e.g., `OpenAiService.get_recommendation(prompt)`).
    *   The API key (`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`) will be used directly in the service for this PoC. **Note: This is NOT secure for production.** For a real project, use Rails credentials or environment variables.
    *   Structure prompts to guide the AI for:
        *   Understanding user intent (browsing, asking for recommendations, ordering).
        *   Providing product suggestions based on DummyJSON data (or a summary of it).
        *   Collecting required order information step-by-step.
    *   Parse AI responses to extract actionable information (e.g., product names, intent to order).
*   **Error Handling:** Basic `begin/rescue` blocks for network issues or API errors. Log errors to the console for debugging.
