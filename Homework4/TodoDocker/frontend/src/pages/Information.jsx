import React, { useState, useEffect } from 'react';
import { Modal, Card, Row, Col, Typography, Spin, Image, Space, Tag } from 'antd';
import { InfoCircleOutlined, GlobalOutlined, CodeOutlined, DeploymentUnitOutlined } from '@ant-design/icons';
import AlertDialog from '../components/AlertDialog.jsx';
import { fetchInfo } from '../api/info.js';

const { Title, Text, Paragraph } = Typography;

function Information() {
  const [loading, setLoading] = useState(false);
  const [serverInfo, setServerInfo] = useState(null);
  const [alert, setAlert] = useState({ open: false, type: 'success', title: '', content: '' });

  const showAlert = (type, title, content) => {
    setAlert({ open: true, type, title, content });
  };

  const closeAlert = () => setAlert(prev => ({ ...prev, open: false }));

  const loadInfo = async () => {
    setLoading(true);
    try {
      const { data } = await fetchInfo();
      setServerInfo(data);
    } catch (err) {
      showAlert('error', 'Error', 'No se pudieron cargar la información del servidor');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadInfo();
  }, []);

  return (
    <>
      <div style={{ position: 'fixed', bottom: 24, right: 24, zIndex: 1000 }}>
        <Card
          hoverable
          style={{ width: 60, height: 60, borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}
          styles={{ body: { padding: 0 } }}
        >
          <InfoCircleOutlined style={{ fontSize: 24 }} />
        </Card>
      </div>

      <Modal
        title={null}
        open={true}
        footer={null}
        width={800}
        centered
        closable={false}
        styles={{ body: { padding: 0 } }}
      >
        <div style={{ position: 'relative' }}>
          <div style={{
            background: 'linear-gradient(135deg, #1890ff 0%, #096dd9 100%)',
            padding: '24px',
            textAlign: 'center',
            color: 'white'
          }}>
            <Space direction="vertical" size="middle">
              <Image
                src="/light-appLogo.svg"
                preview={false}
                width={80}
              />
              <Title level={3} style={{ color: 'white', margin: 0 }}>
                Información del Servidor
              </Title>
              <Text style={{ color: 'rgba(255,255,255,0.8)' }}>
                Detalles técnicos sobre la implementación
              </Text>
            </Space>
          </div>

          <div style={{ padding: '24px' }}>
            {loading && (
              <div style={{ textAlign: 'center', padding: '40px 0' }}>
                <Spin size="large" />
                <Paragraph>Cargando información del servidor...</Paragraph>
              </div>
            )}

            {serverInfo && (
              <Row gutter={[16, 16]}>
                <Col span={24}>
                  <Card>
                    <Space direction="vertical" size="middle">
                      <Title level={4} style={{ marginTop: 0 }}>
                        <DeploymentUnitOutlined /> Detalles del Host
                      </Title>

                      <Row gutter={16}>
                        <Col span={12}>
                          <Text strong>Nombre del host:</Text>
                          <Tag color="blue" style={{ marginLeft: 8 }}>
                            {serverInfo.hostname}
                          </Tag>
                        </Col>
                        <Col span={12}>
                          <Text strong>Dirección IP:</Text>
                          <Tag color="geekblue" style={{ marginLeft: 8 }}>
                            {serverInfo.ip}
                          </Tag>
                        </Col>
                      </Row>
                    </Space>
                  </Card>
                </Col>

                <Col span={24}>
                  <Card>
                    <Title level={4} style={{ marginTop: 0 }}>
                      <CodeOutlined /> Tecnologías utilizadas
                    </Title>
                    <Space size={[8, 16]} wrap>
                      <Tag color="magenta">React</Tag>
                      <Tag color="red">Vite</Tag>
                      <Tag color="volcano">Ant Design</Tag>
                      <Tag color="orange">Python</Tag>
                      <Tag color="gold">FastAPI</Tag>
                    </Space>
                  </Card>
                </Col>

                <Col span={24}>
                  <Card>
                    <Title level={4} style={{ marginTop: 0 }}>
                      <GlobalOutlined /> Mensaje del servidor
                    </Title>
                    <Paragraph style={{ fontSize: 16 }}>
                      {serverInfo.message}
                    </Paragraph>
                  </Card>
                </Col>
              </Row>
            )}
          </div>
          <div style={{
            background: '#f0f2f5',
            padding: '16px',
            textAlign: 'center',
            borderTop: '1px solid #e8e8e8'
          }}>
            <Text type="secondary">
              © {new Date().getFullYear()} DockerTodo - Todos los derechos reservados
            </Text>
          </div>
        </div>
      </Modal>
      <AlertDialog {...alert} onClose={closeAlert} />
    </>
  );
}

export default Information;