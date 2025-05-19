import React, { useEffect, useState } from 'react';
import { Button } from 'antd';
import TaskForm from '../components/TaskForm.jsx';
import TaskList from '../components/TaskList.jsx';
import AlertDialog from '../components/AlertDialog.jsx';
import { fetchTasks, createTask, deleteTask } from '../api/task.js';

function Homepage() {
  const [tasks, setTasks] = useState([]);
  const [isFormVisible, setFormVisible] = useState(false);
  const [loading, setLoading] = useState(false);
  const [alert, setAlert] = useState({ open: false, type: 'success', title: '', content: '' });

  const showAlert = (type, title, content) => {
    setAlert({ open: true, type, title, content });
  };

  const closeAlert = () => setAlert(prev => ({ ...prev, open: false }));

  const loadTasks = async () => {
    setLoading(true);
    try {
      const { data } = await fetchTasks();
      setTasks(data);
    } catch {
      showAlert('error', 'Error', 'No se pudieron cargar las tareas');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadTasks();
  }, []);

  const handleCreate = async (values) => {
    setLoading(true);
    try {
      const { data } = await createTask(values);
      setTasks(prev => [...prev, data]);
      showAlert('success', 'Éxito', 'Tarea creada correctamente');
      setFormVisible(false);
    } catch {
      showAlert('error', 'Error', 'No se pudo crear la tarea');
    } finally {
      setLoading(false);
    }
  };

  const handleRemove = async (id) => {
    setLoading(true);
    try {
      await deleteTask(id);
      setTasks(prev => prev.filter(t => t._id !== id));
      showAlert('success', 'Éxito', 'Tarea eliminada correctamente');
    } catch {
      showAlert('error', 'Error', 'No se pudo eliminar la tarea');
    } finally {
      setLoading(false);
    }
  };

  const updateTask = (updated) => {
    setTasks(prev => prev.map(task => (task._id === updated._id ? updated : task)));
  };

  return (
    <div style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
      <Button
        type="primary"
        onClick={() => setFormVisible(true)}
        style={{ marginBottom: '16px' }}
        loading={loading}
      >
        Add Task
      </Button>
      <TaskList
        tasks={tasks}
        handleDelete={handleRemove}
        onTaskUpdated={updateTask}
        loading={loading}
      />
      <TaskForm
        open={isFormVisible}
        onCancel={() => setFormVisible(false)}
        onSubmit={handleCreate}
        initialValues={{ title: '', description: '', completed: false }}
        isEdit={false}
        loading={loading}
      />
      <AlertDialog {...alert} onClose={closeAlert} />
    </div>
  );
}

export default Homepage;
