# Project Plan: DummyAIAgent (2-Hour PoC)

**Project Goal:** Build a simple AI agent with a chat interface for users to browse products (from DummyJSON API) and make purchases, with product recommendations powered by an OpenAI-based agent. To be completed within a 2-hour timeframe.

**Tech Stack:**
*   Backend: Ruby 3.2.x, Rails 7.1
*   Frontend: Hotwire (Turbo & Stimulus)
*   Database: SQLite
*   APIs: DummyJSON (products), OpenAI (AI agent)

**Timeline Constraint:** 2 hours. Adherence to `rules/TIMEBOX_STRATEGY.md` is critical.

## Phase 1: Setup & Core Chat (Approx. 50 mins)

1.  **Initialize Rails Application (DummyAIAgent)**
    *   `rails new DummyAIAgent -d sqlite3 --css bootstrap` (Bootstrap for quick styling)
    *   `cd DummyAIAgent`
    *   Initial Git commit: "Initialize Rails 7.1 application with SQLite and Bootstrap"
    *   Add `httparty` and `ruby-openai` gems to Gemfile, then `bundle install`.
    *   Commit: "Add httparty and ruby-openai gems"

2.  **Setup Basic Chat Interface Structure**
    *   Generate `Conversation` model (`rails g model Conversation`) - no initial columns needed beyond timestamps.
    *   Generate `Message` model (`rails g model Message content:text sender_type:string conversation:references`)
    *   Run `rails db:migrate`.
    *   Commit: "Add Conversation and Message models"

3.  **Implement Chat Controller & Views (Hotwire)**
    *   Generate `ChatsController` (`rails g controller Chats show --skip-routes`)
    *   Setup root route to `chats#show`.
    *   In `ChatsController#show`:
        *   Find or create a `Conversation` (e.g., `@conversation = Conversation.last || Conversation.create`).
        *   Load existing messages for that conversation (`@messages = @conversation.messages.order(created_at: :asc)`).
    *   Create `app/views/chats/show.html.erb`:
        *   Container for messages (`<div id="messages" data-controller="messages">`).
        *   Render messages partial.
        *   Form to submit new messages (`form_with model: [@conversation, Message.new], data: { turbo_frame: "new_message" }`).
    *   Create `app/views/messages/_message.html.erb` partial to display individual messages.
    *   Create `app/views/messages/_form.html.erb` partial for the message input.
    *   Commit: "Setup basic ChatsController and views for message display and form"

4.  **Implement Message Creation & Broadcasting (Hotwire)**
    *   Add `create` action to `ChatsController`.
        *   Create a new `Message` associated with the conversation.
        *   Save the message.
        *   Broadcast the new message using Turbo Streams (e.g., `message.broadcast_append_to @conversation`).
    *   Ensure `Message` model has `broadcasts_to :conversation` or similar.
    *   Update `show.html.erb` to include `<turbo-stream-from @conversation>`.
    *   Test basic chat functionality (user sends message, it appears).
    *   Commit: "Implement message creation and Turbo Stream broadcasting"

## Phase 2: Product & AI Integration (Approx. 45 mins)

5.  **Integrate DummyJSON API for Product Display**
    *   Create `app/services/dummy_json_service.rb`.
    *   Implement `fetch_products` method using `HTTParty` to get all products (or a subset).
    *   In `ChatsController` (or a new `ProductsController` if preferred, but keep simple):
        *   Fetch products using the service.
        *   Make products available to the view.
    *   Display a simple list of products in the chat interface or a dedicated section. (Focus on getting data first, then display).
    *   Commit: "Integrate DummyJSON API to fetch and display products"

6.  **Integrate OpenAI API for Basic AI Responses**
    *   Create `app/services/open_ai_service.rb`.
    *   Implement a method to send a prompt (user's message + context) to OpenAI using `ruby-openai` gem and API key.
    *   In `ChatsController#create` (after user message is saved):
        *   Call `OpenAiService` with the user's message.
        *   Create a new `Message` for the AI's response.
        *   Save and broadcast the AI's response.
    *   Initial simple prompt: "You are a helpful e-commerce assistant. The user said: [user_message]. Products available: [list_of_products_or_summary]."
    *   Test AI responding to user messages.
    *   Commit: "Integrate OpenAI API for basic AI agent responses"

## Phase 3: Order Flow & Finalization (Approx. 25 mins)

7.  **Implement Order Information Collection Logic**
    *   Refine OpenAI prompt to guide the AI to ask for order details (name, address, email, phone, product(s), quantity) when user expresses intent to buy.
    *   The AI's response should ideally structure this information or clearly indicate what it has collected.

8.  **Implement Order Model & Creation**
    *   Generate `Order` model (`rails g model Order first_name:string last_name:string address:text postcode:string phone_number:string email:string product_details:text conversation:references`).
    *   Run `rails db:migrate`.
    *   In `ChatsController` (or a new `OrdersController`):
        *   Add an action to create an order. This action will be "called" based on AI's output.
        *   This action saves the order details to the database.
    *   Parse AI's response in `ChatsController` after an AI message. If it indicates all order info is collected, create the `Order` record.
    *   Provide a confirmation message to the user via chat.
    *   Commit: "Add Order model and implement simplified order creation logic"

9.  **Refinements & README (Buffer - as time allows)**
    *   Implement "Start new chat" (e.g., clear current conversation display, start new `Conversation` record).
    *   Ensure conversation history is visible for the current session.
    *   Final testing of the flow.
    *   Update `README.md` with notes, setup instructions, and any deviations or thoughts.
    *   Final Git commit and prepare for submission.
    *   Commit: "Final refinements and README update"

**Contingency:**
*   If DummyJSON or OpenAI integration proves too time-consuming, hardcode product data and AI responses to demonstrate the chat flow.
*   Simplify features aggressively if falling behind schedule (refer to `rules/TIMEBOX_STRATEGY.md`).
