import React, { useState } from 'react';
import { Card, Tag, Dropdown, Menu, Button } from 'antd';
import { EditOutlined, DeleteOutlined, MoreOutlined } from '@ant-design/icons';
import ConfirmDialog from './ConfirmDialog.jsx';
import TaskForm from './TaskForm.jsx';
import AlertDialog from './AlertDialog.jsx';
import { updateTask } from '../api/task.js';

const { Meta } = Card;

const TaskCard = ({ todo, onDelete, onTaskUpdated, loading }) => {
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [alert, setAlert] = useState({ open: false, type: 'success', title: '', content: '' });

  const showAlert = (type, title, content) => {
    setAlert({ open: true, type, title, content });
  };

  const closeAlert = () => setAlert(prev => ({ ...prev, open: false }));

  const handleDelete = () => {
    onDelete(todo._id);
    setConfirmOpen(false);
  };

  const handleUpdate = async (values) => {
    try {
      const { data } = await updateTask(todo._id, values);
      onTaskUpdated(data);
      showAlert('success', 'Éxito', 'Tarea actualizada correctamente');
      setEditOpen(false);
    } catch {
      showAlert('error', 'Error', 'No se pudo actualizar la tarea');
    }
  };

  const menuItems = [
    {
      key: 'edit',
      label: 'Edit',
      icon: <EditOutlined />,
      onClick: () => setEditOpen(true),
      disabled: loading,
    },
    {
      key: 'delete',
      label: 'Delete',
      icon: <DeleteOutlined />,
      onClick: () => setConfirmOpen(true),
      disabled: loading,
    },
  ];

  return (
    <>
      <Card
        style={{ width: '100%', margin: 16 }}
        actions={[
          <Tag color={todo.completed ? 'green' : 'red'}>
            {todo.completed ? 'Completed' : 'Pending'}
          </Tag>,
          <Dropdown
            menu={{ items: menuItems }}
            trigger={['click']}
            placement="bottomRight"
          >
            <Button type="text" icon={<MoreOutlined />} size="small" />
          </Dropdown>,
        ]}
      >
        <Meta title={todo.title} description={todo.description} />
      </Card>

      <ConfirmDialog
        open={confirmOpen}
        onCancel={() => setConfirmOpen(false)}
        onConfirm={handleDelete}
        title="¿Eliminar tarea?"
        content={`¿Estás seguro de eliminar \"${todo.title}\"?`}
      />

      <TaskForm
        open={editOpen}
        onCancel={() => setEditOpen(false)}
        onSubmit={handleUpdate}
        initialValues={todo}
        isEdit
        loading={loading}
      />

      <AlertDialog {...alert} onClose={closeAlert} />
    </>
  );
};

export default TaskCard;