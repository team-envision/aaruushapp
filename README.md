

---

# **Aaruush Connect - Environment Setup & Firebase Integration**  

To set up the environment variables and Firebase for the project, follow these steps:  

---

## **1. Create the `.env` File**  
- Navigate to the `assets/` folder and create a `.env` file.  

## **2. Edit the `.env` File**  
- Open the `.env` file and copy this template. Replace the placeholders with the URLs provided by the organizers.  

  ```bash
  API_URL=<your-api-url>
  CDN_URL=<your-cdn-url>
  ```

## **3. Save the `.env` File**  
- Ensure the `.env` file is correctly placed in the root directory of the project.  

---

## **4. Firebase Setup & Integration**  

### **Step 1: Ensure Firebase Access**  
- **Make sure you are added to the Firebase account of Aaruush.**  
- Contact the Firebase owner to get the necessary permissions.  

### **Step 2: Install & SetUp Firebase CLI**  
- If you haven't installed Firebase CLI, download it from:  
  👉 [FlutterFire CLI Installation Guide]([https://firebase.google.com/docs/cli#install_the_firebase_cli](https://firebase.flutter.dev/docs/cli/)  


### **Step 3: Configure Firebase for Flutter**  
- Navigate to the root of your Flutter project and run:  

  ```bash
  dart run flutterfire configure
  ```

- Follow the CLI prompts:
  - Select the Firebase project for Aaruush.
  - Choose the platforms (iOS, Android).
  - The `firebase_options.dart` file will be generated automatically.  




## **5. Initialize the Project**  
- Run the following command to fetch dependencies and start the project:  

  ```bash
  flutter pub get
  flutter run
  ```

---
