/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package GUI;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import javax.swing.*;
import javax.swing.JOptionPane;

/**
 *
 * @author rpacu
 */
public class LoginJFrame extends javax.swing.JFrame {
    public static String currentUsername = "";
    private static final java.util.logging.Logger logger =
            java.util.logging.Logger.getLogger(LoginJFrame.class.getName());

    // Stores username and password
    public static final java.util.Map<String, String> residentAccounts =
            new java.util.HashMap<>();

    // Stores username and resident's full name
    public static final java.util.Map<String, String> residentNames =
            new java.util.HashMap<>();
private Connection conn;
    public LoginJFrame() {
        initComponents();
        setExtendedState(javax.swing.JFrame.MAXIMIZED_BOTH);
        connectDB();
        // Do not call this.dispose() here!
    }
     private void connectDB() {  // STEP 3
     try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/barangaycugmanonlinedocumentrequestforms";
        conn = DriverManager.getConnection(url, "root", "");

        System.out.println("Database connected successfully!");

    } catch (ClassNotFoundException | SQLException e) {
        conn = null;
        e.printStackTrace();
        JOptionPane.showMessageDialog(
            this,
            "Database connection failed!\n" + e.getMessage(),
            "Connection Error",
            JOptionPane.ERROR_MESSAGE
        );
    }
}


private void loginUser() {
    String username = txtUsername.getText().trim();
    String password = new String(jpassword.getPassword());

    if (username.isEmpty() || password.isEmpty()) {
        JOptionPane.showMessageDialog(
            this,
            "Please enter your username and password."
        );
        return;
    }

    if (conn == null) {
        JOptionPane.showMessageDialog(
            this,
            "Database is not connected. Please check MySQL.",
            "Connection Error",
            JOptionPane.ERROR_MESSAGE
        );
        return;
    }

    try {
        // 1. Check the admin account in the database.
        String adminSQL =
            "SELECT admin_id FROM admins " +
            "WHERE username = ? AND password = ?";

        try (PreparedStatement pst = conn.prepareStatement(adminSQL)) {
            pst.setString(1, username);
            pst.setString(2, password);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    JOptionPane.showMessageDialog(
                        this,
                        "Admin connected to database successfully!"
                    );

                    AdminMenuJFrame adminMenu = new AdminMenuJFrame();
                    adminMenu.setLocationRelativeTo(null);
                    adminMenu.setVisible(true);
                    this.dispose();
                    return;
                }
            }
        }

        // 2. If not admin, check the registered resident.
        String residentSQL =
            "SELECT resident_id, firstname, lastname " +
            "FROM residents WHERE username = ? AND password = ?";

        try (PreparedStatement pst = conn.prepareStatement(residentSQL)) {
            pst.setString(1, username);
            pst.setString(2, password);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    String residentName =
                        rs.getString("firstname") + " " +
                        rs.getString("lastname");
                    
                      currentUsername = username; 
                      
                    JOptionPane.showMessageDialog(
                        this, 
                        "Resident connected to database successfully!"
                    );

                    ResidentMenu residentMenu =
                        new ResidentMenu(residentName);
                    residentMenu.setLocationRelativeTo(null);
                    residentMenu.setVisible(true);
                    this.dispose();
                    return;
                }
            }
        }

        // 3. Neither account matched.
        JOptionPane.showMessageDialog(
            this,
            "Invalid username or password.",
            "Login Failed",
            JOptionPane.ERROR_MESSAGE
        );

        // Keep the username so the user can try again.
        jpassword.setText("");
        txtUsername.requestFocusInWindow();

    } catch (SQLException e) {
        JOptionPane.showMessageDialog(
            this,
            "Database login error:\n" + e.getMessage(),
            "Login Error",
            JOptionPane.ERROR_MESSAGE
        );
        e.printStackTrace();
    }
}
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">                          
    private void initComponents() {

        jLabel3 = new javax.swing.JLabel();
        txtUsername = new javax.swing.JTextField();
        btnLogin = new javax.swing.JButton();
        jLabel4 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jpassword = new javax.swing.JPasswordField();
        jLabel8 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jLabel3.setFont(new java.awt.Font("Tahoma", 1, 15)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 255, 255));
        jLabel3.setText("USERNAME:");
        getContentPane().add(jLabel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(860, 150, -1, 30));
        getContentPane().add(txtUsername, new org.netbeans.lib.awtextra.AbsoluteConstraints(1020, 150, 180, 40));

        btnLogin.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        btnLogin.setText("LOG IN");
        btnLogin.addActionListener(this::btnLoginActionPerformed);
        getContentPane().add(btnLogin, new org.netbeans.lib.awtextra.AbsoluteConstraints(1070, 270, -1, -1));

        jLabel4.setBackground(new java.awt.Color(0, 0, 0));
        jLabel4.setFont(new java.awt.Font("Segoe UI", 1, 13)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setText("Create New Account");
        jLabel4.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel4MouseClicked(evt);
            }
        });
        getContentPane().add(jLabel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(860, 270, -1, 30));

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 15)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(255, 255, 255));
        jLabel2.setText("PASSWORD:");
        getContentPane().add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(860, 210, -1, 30));

        jLabel5.setFont(new java.awt.Font("Segoe UI", 1, 30)); // NOI18N
        jLabel5.setForeground(new java.awt.Color(255, 255, 255));
        jLabel5.setText("BARANGAY CUGMAN ONLINE DOCUMENT REQUEST FORM SYSTEM");
        getContentPane().add(jLabel5, new org.netbeans.lib.awtextra.AbsoluteConstraints(170, 30, -1, -1));

        jpassword.addActionListener(this::jpasswordActionPerformed);
        getContentPane().add(jpassword, new org.netbeans.lib.awtextra.AbsoluteConstraints(1020, 210, 180, 40));

        jLabel8.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel8.setForeground(new java.awt.Color(255, 255, 255));
        jLabel8.setText("The Barangay Cugman Document Request Form System is a computerized system designed to make");
        getContentPane().add(jLabel8, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 350, 790, 20));

        jLabel9.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel9.setForeground(new java.awt.Color(255, 255, 255));
        jLabel9.setText("requesting barangay documents easier, faster, and more convenient for residents. Instead of relying ");
        getContentPane().add(jLabel9, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 370, 770, 20));

        jLabel10.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel10.setForeground(new java.awt.Color(255, 255, 255));
        jLabel10.setText("entirely on manual processes, residents can submit their document requests through the system and");
        getContentPane().add(jLabel10, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 390, 770, 20));

        jLabel6.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel6.setForeground(new java.awt.Color(255, 255, 255));
        jLabel6.setText("check the status of their requests.");
        getContentPane().add(jLabel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 410, 270, 20));

        jLabel11.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel11.setForeground(new java.awt.Color(255, 255, 255));
        jLabel11.setText("The system allows the administrator to view, approve, or reject requests and provide comments when");
        getContentPane().add(jLabel11, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 470, 780, 20));

        jLabel12.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel12.setForeground(new java.awt.Color(255, 255, 255));
        jLabel12.setText("necessary. It helps organize resident information, manage document requests, and reduce paperwork.");
        getContentPane().add(jLabel12, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 490, 790, 20));

        jLabel13.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel13.setForeground(new java.awt.Color(255, 255, 255));
        jLabel13.setText("Our goal is to provide a simple, reliable, and efficient way to manage document requests in Barangay");
        getContentPane().add(jLabel13, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 540, 780, 20));

        jLabel14.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel14.setForeground(new java.awt.Color(255, 255, 255));
        jLabel14.setText("Cugman. Through this system, we aim to improve service, save time, and make the document request ");
        getContentPane().add(jLabel14, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 560, 780, 20));

        jLabel15.setFont(new java.awt.Font("Segoe UI", 1, 16)); // NOI18N
        jLabel15.setForeground(new java.awt.Color(255, 255, 255));
        jLabel15.setText("process more organized for both residents and barangay officials.");
        getContentPane().add(jLabel15, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 580, 500, 20));

        jLabel16.setFont(new java.awt.Font("Segoe UI", 1, 20)); // NOI18N
        jLabel16.setForeground(new java.awt.Color(255, 255, 255));
        jLabel16.setText("“Making Document Requests Easier, Faster, and More Convenient for Every Resident.”");
        getContentPane().add(jLabel16, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 290, 820, 40));

        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/background.png"))); // NOI18N
        jLabel1.setText("jLabel1");
        getContentPane().add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, -20, 1350, 790));

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>                        

    private void jLabel4MouseClicked(java.awt.event.MouseEvent evt) {                                     
       new RegisterJFrame().setVisible(true);
       this.dispose();
    }                                    

    private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {                                         
      loginUser();

    }                                        

    private void jpasswordActionPerformed(java.awt.event.ActionEvent evt) {                                          
        // TODO add your handling code here:
    }                                         

        
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ReflectiveOperationException | javax.swing.UnsupportedLookAndFeelException ex) {
            logger.log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> new LoginJFrame().setVisible(true));
    }

    // Variables declaration - do not modify                     
    private javax.swing.JButton btnLogin;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPasswordField jpassword;
    private javax.swing.JTextField txtUsername;
    // End of variables declaration                   

    
} 
