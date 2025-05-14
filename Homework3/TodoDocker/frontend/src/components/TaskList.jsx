import React from 'react';
import { Row, Col } from 'antd';
import TaskCard from './TaskCard.jsx';

function TaskList({ tasks, handleDelete, onTaskUpdated, loading }) {
  return (
    <div style={{ maxWidth: '1400px', margin: '0 auto' }}>
      <Row gutter={[16, 16]}>
        {tasks.map(task => (
          <Col key={task._id} xs={24} sm={12} md={8} lg={6} xl={6}>
            <TaskCard
              todo={task}
              onDelete={handleDelete}
              onTaskUpdated={onTaskUpdated}
              loading={loading}
            />
          </Col>
        ))}
      </Row>
    </div>
  );
}

export default TaskList;