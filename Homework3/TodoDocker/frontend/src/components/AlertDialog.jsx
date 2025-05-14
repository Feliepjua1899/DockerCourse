import React from 'react';
import { Modal, Button, Space } from 'antd';
import { CheckCircleFilled, CloseCircleFilled, ExclamationCircleFilled } from '@ant-design/icons';

const AlertDialog = ({
  open = true,
  type = 'success',
  title,
  content,
  onClose,
}) => {
  const getIconAndColor = () => {
    switch (type) {
      case 'success':
        return { icon: <CheckCircleFilled />, color: '#52c41a' };
      case 'error':
        return { icon: <CloseCircleFilled />, color: '#f5222d' };
      case 'warning':
        return { icon: <ExclamationCircleFilled />, color: '#faad14' };
      default:
        return { icon: null, color: '#1890ff' };
    }
  };

  const { icon, color } = getIconAndColor();

  return (
    <Modal
      open={open}
      title={null}
      footer={null}
      closable={false}
      centered
      width={400}
      style={{ textAlign: 'center' }}
    >
      <div style={{ padding: '24px' }}>
        <div style={{ fontSize: '48px', color }}>{icon}</div>
        <h2 style={{ margin: '16px 0', color }}>{title}</h2>
        <p>{content}</p>
        <Space style={{ marginTop: '24px' }}>
          <Button type="primary" onClick={onClose}>
            OK
          </Button>
        </Space>
      </div>
    </Modal>
  );
};

export default AlertDialog;