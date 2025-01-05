import './App.css';
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';
import { Route, Routes } from 'react-router-dom';
import CustomerRouters from './Routers/CustomerRouters';
import Checkout from './customer/pages/Checkout/Checkout';
import PaymentResult from './customer/pages/Checkout/PaymentResult';
import SignIn from './customer/pages/User/SignIn';
import SignUp from './customer/pages/User/SignUp';
import ResetPassword from './customer/pages/User/ResetPassword';
import ResetPasswordResult from './customer/pages/User/ResetPasswordResult';
import AdminLayout from './layouts/AdminLayout';
import CategoryList from './components/categories/CategoryList';
import ProductList from './components/products/ProductList';
import OrderList from './components/orders/OrderList';
import UserList from './components/users/UserList';

function App() {
  return (
    <Routes>
      <Route path='/*' element={<CustomerRouters />} ></Route>
        <Route path="/cart/checkout" element={<Checkout />}>
        </Route>
        <Route path="/payment-result/*" element={<PaymentResult />}>
          {" "}
        </Route>
        <Route path="/sign-in" element={<SignIn />}>
          {" "}
        </Route>
        <Route path="/sign-up" element={<SignUp />}>
          {" "}
        </Route>
        <Route path="/reset-password" element={<ResetPassword />}>
          {" "}
        </Route>
        <Route path="/reset-password/result/*" element={<ResetPasswordResult />}>
          {" "}
        </Route>
        <Route path="/admin/*" element={
          <AdminLayout>
            <Routes>
              <Route path="categories" element={<CategoryList />} />
              <Route path="products" element={<ProductList />} />
              <Route path="orders" element={<OrderList />} />
              <Route path="users" element={<UserList />} />
              {/* Add other admin routes here */}
            </Routes>
          </AdminLayout>
        } />
    </Routes>
    
  );
}

export default App;
