# Finance App

Welcome to the Finance App, a Flutter application designed to help you manage your finances efficiently. This app follows the clean architecture principles and utilizes the BLoC state management pattern to provide a scalable and maintainable codebase.

## Screens

### 1. Splash Screen
- Displayed when the app is launched.
- Provides a brief introduction to the app.
- Navigates to the Sign In screen after a short delay.

### 2. Sign In and Sign Up Screen
- Allows users to sign in with existing credentials or sign up for a new account.
- Provides a smooth authentication process.

### 3. Home Screen
- Displays an overview of the user's financial status.
- Includes a summary of income, expenses, and savings.
- Navigates to other sections like Add Transaction, Add Bills, My Bills, and Statistics.

### 4. Add Transaction Screen
- Enables users to log their financial transactions.
- Captures details such as amount, category, and description.
- Utilizes the BLoC pattern for managing state and data flow.

### 5. Add Bills Screen
- Allows users to add upcoming bills and their due dates.
- Provides a user-friendly interface for bill management.

### 6. My Bills Screen
- Displays a list of all upcoming bills.
- Allows users to mark bills as paid or delete them.
- Offers a clear overview of financial obligations.

### 7. Statistics Screen
- Presents graphical representations of the user's spending habits.
- Includes charts and graphs to visualize income, expenses, and savings.
- Provides insights into how much money has been spent in different categories.


### Application ScreenShots
<table>
  <tr>
    <td align="center"><img src="https://github.com/DHRUVA-N-L-CHOUDHARY/financeapp/assets/96297602/a0ba2860-6eb4-4a05-93b2-c5c8179d07da" alt="Splash Screen" width="300"/></td>
    <td align="center"><img src="https://github.com/DHRUVA-N-L-CHOUDHARY/financeapp/assets/96297602/d35cce1a-85ac-4320-b125-dd2546edd157 " alt="Sign In Screen" width="300"/></td>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/DHRUVA-N-L-CHOUDHARY/financeapp/assets/96297602/9f9694db-6957-4a70-a72f-a3842d01bbd6" alt="Home Screen" width="300"/></td>
    <td align="center"><img src="https://github.com/DHRUVA-N-L-CHOUDHARY/financeapp/assets/96297602/1c54d323-566f-437a-bf7d-19f0e4fa5c54" alt="Add Transaction Screen" width="300"/></td>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/DHRUVA-N-L-CHOUDHARY/financeapp/assets/96297602/a44d3655-18e5-4bc7-bab6-201e33c4339c" alt="Add Bills Screen" width="300"/></td>
    
</table>



## Clean Architecture and BLoC State Management

This app follows the clean architecture principles to ensure separation of concerns and maintainability. The BLoC pattern is used for state management, providing a clear and scalable structure for handling business logic and UI components.

## Getting Started

To run the Finance App on your local machine, follow these steps:

1. Clone the repository:
   git clone https://github.com/your-username/finance-app.git
   Navigate to the project directory:
2. Install dependencies:
   cd finance-app
   flutter pub get
   
3. Run the app:
   flutter run
   
License
This project is licensed under the MIT License.