import React from "react";
import PropTypes from "prop-types";
import { List, ListItem, ListItemIcon, ListItemText, Button, Box } from "@mui/material";
import AccountCircleIcon from "@mui/icons-material/AccountCircle";
import CreditCardIcon from "@mui/icons-material/CreditCard";
import TocIcon from "@mui/icons-material/Toc";
import { useNavigate } from "react-router-dom"; // Import useNavigate

Sidebar.propTypes = {
  onMenuClick: PropTypes.func,
};

function Sidebar({ filters, onMenuClick }) {
  const navigate = useNavigate(); // Initialize useNavigate

  const menuItems = [
    { text: "Hồ sơ", icon: <AccountCircleIcon /> },
    { text: "Lịch sử đặt hàng", icon: <TocIcon /> },
    { text: "Đơn đặt hàng và hóa đơn", icon: <CreditCardIcon /> },
  ];

  const handleClickMenu = (menu) => {
    if (onMenuClick) {
      onMenuClick(menu);
    }
  };

  const handleNavigateToAdmin = () => {
    navigate("/admin"); // Navigate to /admin
  };

  return (
    <Box>
      <List>
        {menuItems.map((item, index) => (
          <ListItem button key={index} onClick={() => handleClickMenu(item.text)}>
            <ListItemIcon>{item.icon}</ListItemIcon>
            <ListItemText primary={item.text} />
          </ListItem>
        ))}
      </List>

      {/* Button to navigate to admin */}
      <Box mt={2} textAlign="center">
        <Button variant="contained" color="primary" onClick={handleNavigateToAdmin}>
          Go to Admin
        </Button>
      </Box>
    </Box>
  );
}

export default Sidebar;
