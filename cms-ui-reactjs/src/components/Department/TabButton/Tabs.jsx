export default function Tabs({ children, buttons, ButtonContainer }) {
  return (
    <>
      <ButtonContainer>{buttons}</ButtonContainer>
      {children}
    </>
  );
}
