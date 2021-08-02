import axios from 'axios';

const axiosConfig = {
  headers: {
    accept: 'application/json',
  },
};

const getBookingResponse = (e) => {
  const form = e.target;
  const formData = new FormData(form);

  axios
    .post(form.action, formData, axiosConfig)
    .then(({ data: { success_message: success_message }}) => {
      // remove form
      e.target.remove();

      // show confirmation message
      var bookingConfirmation = document.querySelector("[data-booking-alert]");
      bookingConfirmation.innerHTML = success_message;
      bookingConfirmation.classList.add("alert--success");
      bookingConfirmation.classList.remove("hidden");
    })
    .catch((error) => {
      var errorContainer = document.querySelector("[data-booking-errors]");

      // remove existing error messages
      errorContainer.innerHTML = '';

      const error_messages = error.response.data.error_messages;
      error_messages.forEach(function(error) {
        var errorMessage = document.createElement("p")
        errorMessage.appendChild(document.createTextNode(error));
        errorContainer.appendChild(errorMessage);
      });
    });

  e.preventDefault();
};

const onloadBooking = () => {
  var bookingFormEl = document.querySelector('[data-booking-form]');

  if (!!bookingFormEl) {
    bookingFormEl.addEventListener("submit", getBookingResponse);
  }
};

// Prevent overwriting on window.onload function by appending to the load event
if (window.attachEvent) { // IE
  window.attachEvent('onload', onloadBooking);
} else if (window.addEventListener) {
  window.addEventListener('load', onloadBooking, false);
} else {
  document.addEventListener('load', onloadBooking, false);
}
