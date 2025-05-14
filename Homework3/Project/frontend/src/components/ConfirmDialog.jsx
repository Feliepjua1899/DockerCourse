import { Modal, Button, Space } from 'antd';
import { ExclamationCircleFilled } from '@ant-design/icons';

const ConfirmDialog = ({
  open,
  title,
  content,
  onCancel,
  onConfirm,
}) => {
  return (
    <Modal
      open={open}
      title={
        <Space>
          <ExclamationCircleFilled style={{ color: '#faad14' }} />
          {title}
        </Space>
      }
      onCancel={onCancel}
      footer={(
        <Space>
          <Button onClick={onCancel}>Cancelar</Button>
          <Button type="primary" danger onClick={onConfirm}>
            Eliminar
          </Button>
        </Space>
      )}
      centered
    >
      <p>{content}</p>
    </Modal>
  );
};

export default ConfirmDialog;