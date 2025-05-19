import React, { useEffect } from 'react';
import { Form, Input, Button, Checkbox, Modal } from 'antd';

const TaskForm = ({
  open,
  onCancel,
  onSubmit,
  initialValues = { title: '', description: '', completed: false },
  isEdit = false,
  loading = false
}) => {
  const [form] = Form.useForm();

  useEffect(() => {
    if (open) {
      form.resetFields();
      form.setFieldsValue(initialValues);
    }
  }, [open, initialValues, form]);

  const handleSubmit = async (values) => {
    await onSubmit(values);
  };

  return (
    <Modal
      title={isEdit ? "Edit Task" : "Add New Task"}
      open={open}
      onCancel={onCancel}
      footer={null}
      afterClose={() => form.resetFields()}
      destroyOnClose
    >
      <Form
        form={form}
        initialValues={initialValues}
        onFinish={handleSubmit}
        layout="vertical"
      >
        <Form.Item name="title" label="Title">
          <Input placeholder="Task title" />
        </Form.Item>

        <Form.Item name="description" label="Description">
          <Input.TextArea placeholder="Task description" rows={4} />
        </Form.Item>

        <Form.Item name="completed" valuePropName="checked">
          <Checkbox>Completed</Checkbox>
        </Form.Item>

        <Form.Item>
          <Button type="primary" htmlType="submit" block loading={loading}>
            {isEdit ? "Update Task" : "Add Task"}
          </Button>
        </Form.Item>
      </Form>
    </Modal>
  );
};

export default TaskForm;