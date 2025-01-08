import React, { useState, useEffect } from 'react';
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  IconButton
} from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import { orderService } from '../../services/orderService';

const OrderList = () => {
  const [orders, setOrders] = useState([]);
  const [selectedOrder, setSelectedOrder] = useState(null);
  const [isStatusModalOpen, setStatusModalOpen] = useState(false);
  const [isDeleteModalOpen, setDeleteModalOpen] = useState(false);
  const [status, setStatus] = useState('');

  useEffect(() => {
    loadOrders();
  }, []);

  const loadOrders = async () => {
    try {
      const data = await orderService.getAllOrders();
      setOrders(data);
    } catch (error) {
      console.error('Error loading orders:', error);
    }
  };

  const handleStatusUpdate = async (orderId, status) => {
    try {
      await orderService.updateOrderStatus(orderId, status);
      loadOrders();
      setStatusModalOpen(false);
      setStatus('');
    } catch (error) {
      console.error('Error updating order status:', error);
    }
  };

  const handleDelete = async (orderId) => {
    try {
      await orderService.deleteOrder(orderId);
      loadOrders();
      setDeleteModalOpen(false);
    } catch (error) {
      console.error('Error deleting order:', error);
    }
  };

  const styles = {
    modal: {
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      backgroundColor: 'rgba(0, 0, 0, 0.5)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      zIndex: 1000
    },
    modalContent: {
      backgroundColor: 'white',
      padding: '20px',
      borderRadius: '8px',
      width: '400px'
    },
    select: {
      width: '100%',
      padding: '8px',
      marginBottom: '20px'
    },
    buttonGroup: {
      display: 'flex',
      justifyContent: 'flex-end',
      gap: '10px',
      marginTop: '20px'
    },
    button: {
      padding: '8px 16px',
      borderRadius: '4px',
      border: 'none',
      cursor: 'pointer'
    }
  };

  return (
    <div>
      <h2>Quản lý đơn hàng</h2>
      
      {/* Orders Table */}
      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>ID Đơn Hàng</TableCell>
              <TableCell>Ngày tạo đơn hàng</TableCell>
              <TableCell>Trạng thái thanh toán</TableCell>
              <TableCell>Trạng thái đơn hàng</TableCell>
              <TableCell>Tổng giá</TableCell>
              <TableCell>Hành động</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {orders.map((order) => (
              <TableRow key={order.id}>
                <TableCell>{order.id}</TableCell>
                <TableCell>{order.date}</TableCell>
                <TableCell>{order.paymentStatus}</TableCell>
                <TableCell>{order.fulfillmentStatus}</TableCell>
                <TableCell>{order.total}</TableCell>
                <TableCell>
                  <IconButton onClick={() => {
                    setSelectedOrder(order);
                    setStatusModalOpen(true);
                  }}>
                    <Edit />
                  </IconButton>
                  <IconButton onClick={() => {
                    setSelectedOrder(order);
                    setDeleteModalOpen(true);
                  }}>
                    <Delete />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      {/* Status Update Modal */}
      {isStatusModalOpen && selectedOrder && (
        <div style={styles.modal} onClick={() => setStatusModalOpen(false)}>
          <div style={styles.modalContent} onClick={e => e.stopPropagation()}>
            <h3>Cập nhật trạng thái đơn hàng</h3>
            <select 
              style={styles.select}
              value={status}
              onChange={(e) => setStatus(e.target.value)}
            >
              <option value="">Chọn trạng thái</option>
              <option value="1">Đang xử lý</option>
              <option value="2">Hoàn thành</option>
              <option value="3">Hủy</option>
              <option value="4">Đang vận chuyển</option>
            </select>
            <div style={styles.buttonGroup}>
              <button 
                style={{ ...styles.button, backgroundColor: '#f0f0f0' }}
                onClick={() => setStatusModalOpen(false)}
              >
                Hủy
              </button>
              <button
                style={{ ...styles.button, backgroundColor: '#1976d2', color: 'white' }}
                onClick={() => handleStatusUpdate(selectedOrder.id, status)}
              >
                Cập nhật
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Delete Confirmation Modal */}
      {isDeleteModalOpen && selectedOrder && (
        <div style={styles.modal} onClick={() => setDeleteModalOpen(false)}>
          <div style={styles.modalContent} onClick={e => e.stopPropagation()}>
            <h3>Xác nhận xóa</h3>
            <p>Bạn có muốn hủy đơn hàng này {selectedOrder.id}?</p>
            <div style={styles.buttonGroup}>
              <button 
                style={{ ...styles.button, backgroundColor: '#f0f0f0' }}
                onClick={() => setDeleteModalOpen(false)}
              >
                Hủy
              </button>
              <button
                style={{ ...styles.button, backgroundColor: '#dc3545', color: 'white' }}
                onClick={() => handleDelete(selectedOrder.id)}
              >
                Xóa
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default OrderList;