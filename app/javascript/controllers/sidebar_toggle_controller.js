import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar-toggle"
export default class extends Controller {
  static targets = ["sidebar", "mainContent"]

  connect() {
    // Optional: Check screen size on connect and collapse if small
    // this.toggleBasedOnWindowSize()
    // window.addEventListener('resize', this.toggleBasedOnWindowSize.bind(this))
  }

  // disconnect() {
  //   window.removeEventListener('resize', this.toggleBasedOnWindowSize.bind(this))
  // }

  toggle() {
    this.sidebarTarget.classList.toggle("collapsed");
    // The mainContentTarget might also need a class toggled if its margin/padding needs to adjust
    // when the sidebar is collapsed, to prevent content from being overlapped or to resize.
    // For now, assuming the CSS for .sidebar.collapsed and .main-chat-area handles layout.
    // If mainContentTarget needs to react, you could do:
    // this.mainContentTarget.classList.toggle("sidebar-is-collapsed"); 
    // And then add corresponding CSS for .main-chat-area.sidebar-is-collapsed
  }

  // Optional: Example for responsive toggling
  // toggleBasedOnWindowSize() {
  //   if (window.innerWidth < 768) { // Bootstrap's md breakpoint
  //     if (!this.sidebarTarget.classList.contains("collapsed")) {
  //       this.toggle()
  //     }
  //   } else {
  //     if (this.sidebarTarget.classList.contains("collapsed")) {
  //       // this.toggle() // Optionally re-open on larger screens if it was auto-collapsed
  //     }
  //   }
  // }
}
