class CartItemsController < ApplicationController
end

<h1>Product Description</h1>
<p>Redirecting to the app or store...</p>

<script type="text/javascript">
  (function() {
    var appOpened = false;

    var app = {
      launchApp: function() {
        // Add timestamp to avoid caching issues
        var deepLink = "<%= @data %>?t=" + new Date().getTime();
        window.location.href = deepLink;

        appOpened = true;
      },

      openWebApp: function() {
        if (!appOpened) {
          try {
            // Open the correct store based on server-side logic
            window.location.href = "<%= @store_url %>";
          } catch (e) {
            console.error("Error opening web app: " + e.message);
          }
        }
      }
    };

    app.launchApp();

    // After 8 seconds, if the app isn't opened, fallback to the web store
    setTimeout(app.openWebApp, 8000);
  })();
</script>
