import React, { useState } from "react";
import {
  Box,
  Typography,
  TableContainer,
  Paper,
  Snackbar,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  IconButton,
} from "@mui/material";
import EditIcon from "@mui/icons-material/Edit";
import VisibilityIcon from "@mui/icons-material/Visibility";
import { useSelector } from "react-redux";
import { userInfor } from "../../../../app/Selectors";
import useOrder from "../../../../hooks/useOrder";
import { formatPrice } from "../../../../utils";
import { orderService } from "../../../../services/orderService";

const OrderHistory = () => {
  const user = useSelector(userInfor);
  const [refreshFlag, setRefreshFlag] = useState(false); // New state to trigger re-fetch
  const orders = useOrder(user.id, refreshFlag) || [];
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");
  const [selectedOrder, setSelectedOrder] = useState(null);

  const handleStatusUpdate = async (orderId) => {
    try {
      const cleanedOrderId = orderId.replace(/^#/, "");
      await orderService.updateOrderStatus(cleanedOrderId, 3);
      setSnackbarMessage(`Đơn hàng ${orderId} đã được hủy thành công.`);
      setSnackbarOpen(true);
      
      // Trigger a re-fetch of the orders by toggling the refreshFlag
      setRefreshFlag(prev => !prev); // Toggle the flag to trigger a re-fetch
    } catch (error) {
      console.error("Error updating order status:", error);
      setSnackbarMessage("Có lỗi xảy ra khi hủy đơn hàng.");
      setSnackbarOpen(true);
    }
  };

  const handleViewDetails = (order) => {
    setSelectedOrder(order);
  };

  const handleCloseDetails = () => {
    setSelectedOrder(null);
  };

  return (
    <Box p={3}>
      <Typography variant="h4" gutterBottom>
        Lịch sử đặt hàng
      </Typography>

      <TableContainer component={Paper} sx={{ width: "100%", maxWidth: "100%", overflowX: "auto", padding: 1 }}>
        <Table stickyHeader aria-label="sticky table">
          <TableHead>
            <TableRow>
              <TableCell>Đặt hàng</TableCell>
              <TableCell>Ngày</TableCell>
              <TableCell>Trạng thái thanh toán</TableCell>
              <TableCell>Trạng thái thực hiện</TableCell>
              <TableCell>Tổng tiền</TableCell>
              <TableCell>Hành động</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {orders.length > 0 ? (
              orders.map((order) => (
                <TableRow key={order.id}>
                  <TableCell>{order.id}</TableCell>
                  <TableCell>{order.date}</TableCell>
                  <TableCell>{order.paymentStatus}</TableCell>
                  <TableCell>{order.fulfillmentStatus}</TableCell>
                  <TableCell>{formatPrice(order.total)}</TableCell>
                  <TableCell>
                    <IconButton onClick={() => handleStatusUpdate(order.id)}>
                      <EditIcon />
                    </IconButton>
                    <IconButton onClick={() => handleViewDetails(order)}>
                      <VisibilityIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))
            ) : (
              <TableRow>
                <TableCell colSpan={6} align="center">
                  Chưa có đơn hàng nào được đặt.
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
      </TableContainer>

      <Snackbar
        open={snackbarOpen}
        autoHideDuration={6000}
        onClose={() => setSnackbarOpen(false)}
        message={snackbarMessage}
      />

      <Dialog open={Boolean(selectedOrder)} onClose={handleCloseDetails}>
        <DialogTitle>Chi tiết đơn hàng {selectedOrder?.id}</DialogTitle>
        <DialogContent>
          <Typography variant="body1">Ngày đặt: {selectedOrder?.date}</Typography>
          <Typography variant="body1">
            Trạng thái thanh toán: {selectedOrder?.paymentStatus}
          </Typography>
          <Typography variant="body1">
            Trạng thái thực hiện: {selectedOrder?.fulfillmentStatus}
          </Typography>
          <Typography variant="body1">
            Tổng tiền: {formatPrice(selectedOrder?.total)}
          </Typography>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDetails} color="primary">
            Đóng
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default OrderHistory;
