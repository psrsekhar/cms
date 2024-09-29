import reactImage from '../../assets/react-core-concepts.png';
import './Header.css';

const colleges = ['Oxford', 'Harward', 'MIT'];
function getRandomInt(max) {
    return Math.floor(Math.random() * (max + 1));
}

export default function Header() {
    const collegeName = colleges[getRandomInt(2)];
    return (
        <header>
            <img src={reactImage} alt="Stylized atom" />
            <h1>College Management System</h1>
            <p>
                The College Management System is a comprehensive web application built using React.js at {collegeName} University.
            </p>
        </header>
    );
}